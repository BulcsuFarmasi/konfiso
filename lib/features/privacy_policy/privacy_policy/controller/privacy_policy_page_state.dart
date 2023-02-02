import 'package:freezed_annotation/freezed_annotation.dart';

part 'privacy_policy_page_state.freezed.dart';

@freezed
class PrivacyPolicyPageState with _$PrivacyPolicyPageState{
  const factory PrivacyPolicyPageState.initial() = _Initial;
  const factory PrivacyPolicyPageState.successful(String privacyPolicyUrl) = _Successful;
}