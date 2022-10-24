import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/widgets/app_drawer/model/app_drawer_repository.dart';

final appDrawerStateNotifierProvider = StateNotifierProvider((Ref ref) => AppDrawerStateNotifier(ref.read(appDrawerRepositoryProvider)));

class AppDrawerStateNotifier extends StateNotifier<AppDrawerState> {

  final AppDrawerRepository _appDrawerRepository;

  AppDrawerStateNotifier(this._appDrawerRepository) : super(AppDrawerState());

  void signOut() {
    _appDrawerRepository.signOut();
  }
}


class AppDrawerState {}