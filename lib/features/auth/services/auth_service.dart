import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/services/auth_remote.dart';
import 'package:konfiso/features/auth/services/auth_storage.dart';
import 'package:konfiso/features/auth/services/stored_user.dart';
import 'package:konfiso/shared/expcetions/network_execption.dart';

final authServiceProvider = Provider((Ref ref) =>
    AuthService(ref.read(authStorageProvider), ref.read(authRemoteProvider)));

class AuthService {
  final AuthStorage _authStorage;
  final AuthRemote _authRemote;
  Timer? refreshTimer;
  StoredUser? user;
  static const url = 'https://identitytoolkit.googleapis.com/v1/accounts:';

  AuthService(this._authStorage, this._authRemote);

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
          validUntil: DateTime.now()
              .add(Duration(seconds: int.parse(authResponse.expiresIn))));
      print('user 1');
      _authStorage.saveUser(user!);
      print('user 2');
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
      // TODO : deserialize it into a classbulcsu
      throw NetworkException(e.response!.data['error']['message']);
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
        validUntil: DateTime.now()
            .add(Duration(seconds: int.parse(responsePayload.expires_in))));

    debugPrint(user!.validUntil.toString());

    _authStorage.saveUser(user!);

    _startTimer(int.parse(responsePayload.expires_in));
  }

  void _startTimer(int secondsUntilRefresh) {
    debugPrint(secondsUntilRefresh.toString());
    refreshTimer = Timer(Duration(seconds: secondsUntilRefresh), _refreshToken);
  }

  void _cancelTimer() {
    if (refreshTimer != null && refreshTimer!.isActive) {
      refreshTimer!.cancel();
    }
  }
}
