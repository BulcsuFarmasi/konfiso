import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/widgets/app_drawer/model/app_drawer_repository.dart';

final appDrawerControllerProvider = Provider((Ref ref) => AppDrawerController(ref.read(appDrawerRepositoryProvider)));

class AppDrawerController {
  final AppDrawerRepository _appDrawerRepository;

  AppDrawerController(this._appDrawerRepository);

  void signOut() {
    _appDrawerRepository.signOut();
  }
}
