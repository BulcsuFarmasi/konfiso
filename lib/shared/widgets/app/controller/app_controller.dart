import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/widgets/app/model/app_repository.dart';

final appControllerProvider =
    Provider((Ref ref) => AppController(ref.read(appRepositoryProvider)));

class AppController {
  final AppRepository _appRepository;

  AppController(this._appRepository);

  void setLocale(String locale) {
    _appRepository.setLocale(locale);
  }
}
