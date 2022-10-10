
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_error.dart';


part 'sign_up_page_state.freezed.dart';

@freezed
class SignUpPageState with _$SignUpPageState {
  const factory SignUpPageState.initial() = _Initial;
  const factory SignUpPageState.inProgress() = _InProgress;
  const factory SignUpPageState.successful() = _Succesful;
  const factory SignUpPageState.error(SignUpError error) = _Error;
}