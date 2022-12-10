import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/services/language_service.dart';

final privacyPolicyServiceProvider = Provider((Ref ref) => PrivacyPolicyService(ref.read(languageServiceProvider)));

class PrivacyPolicyService {
  final LanguageService languageService;

  static const versionNumber = 1;

  PrivacyPolicyService(this.languageService);

  String get privacyPolicyUrl {
    final languageCode = languageService.locale.split('_').first;
    return 'https://konfiso.com/privacy-policy/$languageCode/v$versionNumber/privacy-policy.pdf';
  }
}
