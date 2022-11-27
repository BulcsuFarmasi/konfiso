import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/services/language_service.dart';

final appRepositoryProvider =
    Provider((Ref ref) => AppRepository(ref.read(languageServiceProvider)));

class AppRepository {
  final LanguageService _languageService;

  AppRepository(this._languageService);

  void setLocale(String locale) {
    _languageService.locale = locale;
  }
}
