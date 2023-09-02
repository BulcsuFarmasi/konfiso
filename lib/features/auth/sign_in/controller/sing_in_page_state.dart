import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_error.dart';

part 'sing_in_page_state.freezed.dart';

@freezed
sealed class SignInPageState with _$SignInPageState {
  const factory SignInPageState.initial() = Initial;

  const factory SignInPageState.inProgress() = InProgress;

  const factory SignInPageState.successful() = Successful;

  const factory SignInPageState.error(SignInError error) = Error;
}
