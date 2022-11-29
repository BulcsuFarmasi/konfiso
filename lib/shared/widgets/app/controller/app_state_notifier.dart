import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/widgets/app/controller/app_state.dart';
import 'package:konfiso/shared/widgets/app/model/app_repository.dart';

final appStateNotifierProvider =
    StateNotifierProvider<AppStateNotifier, AppState>((Ref ref) => AppStateNotifier(ref.read(appRepositoryProvider)));

class AppStateNotifier extends StateNotifier<AppState> {
  final AppRepository _appRepository;

  AppStateNotifier(this._appRepository) : super(const AppState.initial());

  void setLocale(String locale) {
    _appRepository.setLocale(locale);
  }

  void watchConnection() {
    _appRepository.watchConnection.listen((connection) {
      if (connection) {
        state = const AppState.connected();
      } else {
        state = const AppState.notConnected();
      }
    });
  }
}
