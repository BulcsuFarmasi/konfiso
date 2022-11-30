import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/data/stored_user.dart';
import 'package:konfiso/features/auth/data/user_signin_status.dart';
import 'package:konfiso/features/auth/services/auth_remote.dart';
import 'package:konfiso/features/auth/services/auth_storage.dart';
import 'package:konfiso/shared/exceptions/network_execption.dart';
import 'package:konfiso/shared/utils/time_util.dart';

final authServiceProvider = Provider(
    (Ref ref) => AuthService(ref.read(authStorageProvider), ref.read(authRemoteProvider), ref.read(timeUtilProvider)));

class AuthService {
  final AuthStorage _authStorage;
  final AuthRemote _authRemote;
  final TimeUtil _timeUtil;
  Timer? refreshTimer;
  StoredUser? user;
  static const url = 'https://identitytoolkit.googleapis.com/v1/accounts:';

  AuthService(
    this._authStorage,
    this._authRemote,
    this._timeUtil,
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
      final authResponse = await _authRemote.signIn(email, password);
      user = StoredUser(
          userId: authResponse.userId!,
          authId: authResponse.localId,
          token: authResponse.idToken,
          refreshToken: authResponse.refreshToken,
          validUntil: _timeUtil.now().add(
                Duration(
                  seconds: int.parse(authResponse.expiresIn),
                ),
              ),
          verified: true);
      _authStorage.saveUser(user!);
      _startTimer(int.parse(authResponse.expiresIn));
      // TODO: own error
    } on DioError catch (e) {
      // TODO : deserialize it into a class
      throw NetworkException(e.response!.data['error']['message']);
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      final authResponse = await _authRemote.signUp(email, password);
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

      _authStorage.saveUser(user!);
      // TODO: own error
    } on DioError catch (e) {
      // TODO : deserialize it into a class
      throw NetworkException(e.response!.data['error']['message']);
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
        final userInfo = (await _authRemote.loadUserInfo(user!.token)).users.first;

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
      await _authRemote.sendPasswordResetEmail(email);
    } on DioError catch (e) {
      throw NetworkException(e.response!.data['error']['message']);
    }
  }

  void _refreshToken() async {
    final responsePayload = await _authRemote.refreshToken(user!.refreshToken);
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
