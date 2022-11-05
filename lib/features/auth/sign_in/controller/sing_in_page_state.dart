import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_error.dart';

part 'sing_in_page_state.freezed.dart';

@freezed
class SignInPageState with _$SignInPageState {
  const factory SignInPageState.initial() = _Initial;
  const factory SignInPageState.inProgress() = _InProgress;
  const factory SignInPageState.successful() = _Successful;
  const factory SignInPageState.error(SignInError error) = _Error;

}