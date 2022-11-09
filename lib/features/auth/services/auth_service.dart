import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/services/auth_remote.dart';
import 'package:konfiso/features/auth/services/auth_storage.dart';
import 'package:konfiso/features/auth/model/stored_user.dart';
import 'package:konfiso/shared/expcetions/network_execption.dart';
import 'package:konfiso/shared/services/time_service.dart';

final authServiceProvider = Provider((Ref ref) => AuthService(
    ref.read(authStorageProvider),
    ref.read(authRemoteProvider),
    ref.read(timeServiceProvider)));

class AuthService {
  final AuthStorage _authStorage;
  final AuthRemote _authRemote;
  final TimeService _timeService;
  Timer? refreshTimer;
  StoredUser? user;
  static const url = 'https://identitytoolkit.googleapis.com/v1/accounts:';

  AuthService(
    this._authStorage,
    this._authRemote,
    this._timeService,
  );

  Future<bool> autoSignIn() async {
    user = await _authStorage.fetchUser();
    if (user != null) {
      _refreshToken();
      return true;
    } else {
      return false;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final authResponse = await _authRemote.signIn(email, password);
      user = StoredUser(
          userId: authResponse.localId,
          token: authResponse.idToken,
          refreshToken: authResponse.refreshToken,
          validUntil: _timeService
              .now()
              .add(Duration(seconds: int.parse(authResponse.expiresIn))));
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
      _authRemote.signUp(email, password);
      // TODO: own error
    } on DioError catch (e) {
      // TODO : deserialize it into a class
      throw NetworkException(e.response!.data['error']['message']);
    } catch (e) {
      print(e);
    }
  }

  void signOut() {
    _cancelTimer();
    _authStorage.deleteUser();
    user = null;
  }

  void _refreshToken() async {
    final responsePayload = await _authRemote.refreshToken(user!.refreshToken);
    user = StoredUser(
        userId: responsePayload.user_id,
        token: responsePayload.id_token,
        refreshToken: responsePayload.refresh_token,
        validUntil: _timeService
            .now()
            .add(Duration(seconds: int.parse(responsePayload.expires_in))));

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
