import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';

final appDrawerRepositoryProvider = Provider((Ref ref) => AppDrawerRepository(ref.read(authServiceProvider)));

class AppDrawerRepository{
  final AuthService _authService;

  AppDrawerRepository(this._authService);

  void signOut() {
    _authService.signOut();
  }
}