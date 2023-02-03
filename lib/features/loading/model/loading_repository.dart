import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/data/user_signin_status.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:konfiso/shared/services/connection_service.dart';

final loadingRepositoryProvider =
    Provider((Ref ref) => LoadingRepository(ref.read(authServiceProvider), ref.read(connectionServiceProvider)));

class LoadingRepository {
  final AuthService _authService;
  final ConnectionService _connectionService;

  LoadingRepository(this._authService, this._connectionService);

  Future<UserSignInStatus> autoSignIn() {
    return _authService.autoSignIn();
  }

  Future<bool> checkInitialConnection() {
    return _connectionService.checkInitialConnection();
  }
}
