import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:konfiso/features/settings/services/services/setting_service.dart';

final appDrawerRepositoryProvider =
    Provider((Ref ref) => AppDrawerRepository(ref.read(authServiceProvider), ref.read(settingsServiceProvider)));

class AppDrawerRepository {
  final AuthService _authService;
  final SettingsService _settingsService;

  AppDrawerRepository(this._authService, this._settingsService);

  void signOut() {
    _authService.signOut();
    _settingsService.clearSettings();
  }
}
