import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/data/stored_user.dart';
import 'package:konfiso/features/auth/data/user_signin_status.dart';
import 'package:konfiso/features/auth/services/auth_api_remote.dart';
import 'package:konfiso/features/auth/services/auth_database_remote.dart';
import 'package:konfiso/features/auth/services/auth_storage.dart';
import 'package:konfiso/shared/exceptions/network_execption.dart';
import 'package:konfiso/features/privacy_policy/services/privacy_poilcy_service.dart';
import 'package:konfiso/shared/utils/time_util.dart';

final authServiceProvider = Provider(
  (Ref ref) => AuthService(
    ref.read(authStorageProvider),
    ref.read(authApiRemoteProvider),
    ref.read(authDatabaseRemoteProvider),
    ref.read(timeUtilProvider),
    ref.read(privacyPolicyServiceProvider),
  ),
);

class AuthService {
  final AuthStorage _authStorage;
  final AuthApiRemote _authApiRemote;
  final AuthDatabaseRemote _authDatabaseRemote;
  final PrivacyPolicyService _privacyPolicyService;
  final TimeUtil _timeUtil;
  Timer? refreshTimer;
  StoredUser? user;
  static const url = 'https://identitytoolkit.googleapis.com/v1/accounts:';

  AuthService(
    this._authStorage,
    this._authApiRemote,
    this._authDatabaseRemote,
    this._timeUtil,
    this._privacyPolicyService,
  );

  Future<UserSignInStatus> autoSignIn() async {
    user = await _authStorage.fetchUser();

    if (user == null) {
      return UserSignInStatus.notSignedIn;
    }

    if (user!.verified) {
      _refreshToken();
      return UserSignInStatus.signedIn;
    } else {
      return UserSignInStatus.notVerified;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final authResponse = await _authApiRemote.signIn(email, password);
      user = StoredUser(
          authId: authResponse.localId,
          token: authResponse.idToken,
          refreshToken: authResponse.refreshToken,
          validUntil: _timeUtil.now().add(
                Duration(
                  seconds: int.parse(authResponse.expiresIn),
                ),
              ),
          verified: true);
      await _authStorage.saveUser(user!);

      final userId = await _authDatabaseRemote.fetchUserIdByAuthId(user!.authId);

      user = user!.copyWith(userId: userId);

      await _authStorage.saveUser(user!);

      _startTimer(int.parse(authResponse.expiresIn));
      // // TODO: own error
    } on DioError catch (e) {
      // TODO : deserialize it into a class
      final errorMessage =
          e.response!.data['error'] is! String ? e.response!.data['error']['message'] : e.response!.data['error'];
      throw NetworkException(errorMessage);
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      final authResponse = await _authApiRemote.signUp(email, password);
      user = StoredUser(
          authId: authResponse.localId,
          token: authResponse.idToken,
          refreshToken: authResponse.refreshToken,
          validUntil: _timeUtil.now().add(
                Duration(
                  seconds: int.parse(authResponse.expiresIn),
                ),
              ),
          verified: false);

      await _authStorage.saveUser(user!);

      _authDatabaseRemote.saveUser(user!.authId, email, _privacyPolicyService.privacyPolicyUrl);

      _authApiRemote.sendVerificationEmail(user!.token);
      // TODO: own error
    } on DioError catch (e) {
      // TODO : deserialize it into a class
      final errorMessage =
          e.response!.data['error'] is! String ? e.response!.data['error']['message'] : e.response!.data['error'];
      throw NetworkException(errorMessage);
    }
  }

  void signOut() {
    _cancelTimer();
    _authStorage.deleteUser();
    user = null;
  }

  Future<void> checkVerification() async {
    final completer = Completer();

    Timer.periodic(const Duration(seconds: 2), (Timer timer) async {
      try {
        final userInfo = (await _authApiRemote.loadUserInfo(user!.token)).users.first;

        if (userInfo.emailVerified) {
          timer.cancel();
          completer.complete();
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });

    return completer.future;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _authApiRemote.sendPasswordResetEmail(email);
    } on DioException catch (e) {
      final String errorMessage =
          e.response!.data['error'] is! String ? e.response!.data['error']['message'] : e.response!.data['error'];
      throw NetworkException(errorMessage);
    }
  }

  void _refreshToken() async {
    final responsePayload = await _authApiRemote.refreshToken(user!.refreshToken);
    user = StoredUser(
      userId: user!.userId,
      authId: responsePayload.user_id,
      token: responsePayload.id_token,
      refreshToken: responsePayload.refresh_token,
      validUntil: _timeUtil.now().add(
            Duration(
              seconds: int.parse(responsePayload.expires_in),
            ),
          ),
      verified: true,
      // verified: false,
    );

    _authStorage.saveUser(user!);

    _startTimer(int.parse(responsePayload.expires_in));
  }

  void _startTimer(int secondsUntilRefresh) {
    refreshTimer = Timer(Duration(seconds: secondsUntilRefresh), _refreshToken);
  }

  void _cancelTimer() {
    if (refreshTimer != null && refreshTimer!.isActive) {
      refreshTimer!.cancel();
    }
  }
}
