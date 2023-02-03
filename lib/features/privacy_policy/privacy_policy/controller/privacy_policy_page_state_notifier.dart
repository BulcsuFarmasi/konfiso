import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/privacy_policy/privacy_policy/controller/privacy_policy_page_state.dart';
import 'package:konfiso/features/privacy_policy/privacy_policy/model/privacy_policy_repository.dart';

final privacyPolicyPageStateNotifierProvider =
    StateNotifierProvider<PrivacyPolicyPageStateNotifier, PrivacyPolicyPageState>(
  (Ref ref) => PrivacyPolicyPageStateNotifier(
    ref.read(privacyPolicyRepositoryProvider),
  ),
);

class PrivacyPolicyPageStateNotifier extends StateNotifier<PrivacyPolicyPageState> {
  PrivacyPolicyPageStateNotifier(this._privacyPolicyRepository) : super(const PrivacyPolicyPageState.initial());

  final PrivacyPolicyRepository _privacyPolicyRepository;

  void loadPrivacyPolicyUrl() {
    final privacyPolicyUrl = _privacyPolicyRepository.loadPrivacyPolicyUrl();

    state = PrivacyPolicyPageState.successful(privacyPolicyUrl);
  }
}
