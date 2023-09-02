import 'package:freezed_annotation/freezed_annotation.dart';

part 'privacy_policy_page_state.freezed.dart';

@freezed
sealed class PrivacyPolicyPageState with _$PrivacyPolicyPageState {
  const factory PrivacyPolicyPageState.initial() = Initial;
  const factory PrivacyPolicyPageState.successful(String privacyPolicyUrl) = Successful;
}
