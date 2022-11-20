import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/shared/services/language_service.dart';
import 'package:konfiso/shared/widgets/app/model/app_repository.dart';

import 'package:mocktail/mocktail.dart';

class MockLanguageService extends Mock implements LanguageService {}

void main () {
  group('AppRepository', () {
    late AppRepository appRepository;
    late LanguageService languageService;
    late String locale;

  setUp(() {
    languageService = MockLanguageService();
    appRepository = AppRepository(languageService);
    locale = 'en';
  });

  void arrangeLanguageServiceLocaleReturnsWithSetLocale() {
    when(() => languageService.locale).thenReturn(locale);
  }

  group('setLocale', () {
    test('should test language service locale property', () {
      arrangeLanguageServiceLocaleReturnsWithSetLocale();

      appRepository.setLocale(locale);

      expect(languageService.locale, locale);
    });
  });


  });
}