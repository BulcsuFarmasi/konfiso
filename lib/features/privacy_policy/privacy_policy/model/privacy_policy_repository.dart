import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/privacy_policy/services/privacy_poilcy_service.dart';

final privacyPolicyRepositoryProvider = Provider(
  (Ref ref) => PrivacyPolicyRepository(
    ref.read(privacyPolicyServiceProvider),
  ),
);

class PrivacyPolicyRepository {
  PrivacyPolicyRepository(this._privacyPolicyService);

  final PrivacyPolicyService _privacyPolicyService;

  String loadPrivacyPolicyUrl() {
    return _privacyPolicyService.privacyPolicyUrl;
  }
}
