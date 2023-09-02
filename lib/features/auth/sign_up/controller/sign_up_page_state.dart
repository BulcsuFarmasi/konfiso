import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_error.dart';

part 'sign_up_page_state.freezed.dart';

@freezed
sealed class SignUpPageState with _$SignUpPageState {
  const factory SignUpPageState.initial(String privacyPolicyUrl) = Initial;

  const factory SignUpPageState.inProgress() = InProgress;

  const factory SignUpPageState.successful() = Successful;

  const factory SignUpPageState.error(SignUpError error, String privacyPolicyUrl) = Error;
}
