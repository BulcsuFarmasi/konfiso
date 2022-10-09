import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';

final loadingRepositoryProvider = Provider((Ref ref) => LoadingRepository(ref.read(authServiceProvider)));

class LoadingRepository {

  final AuthService _authService;

  LoadingRepository(this._authService);

  Future<bool> autoSignIn()  {
    return _authService.autoSignIn();
  }
}