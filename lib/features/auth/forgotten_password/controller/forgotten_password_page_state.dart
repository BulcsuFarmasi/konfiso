import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/auth/forgotten_password/model/forgotten_password_error.dart';

part 'forgotten_password_page_state.freezed.dart';

@freezed
class ForgottenPasswordPageState with _$ForgottenPasswordPageState {
  const factory ForgottenPasswordPageState.initial() = _Initial;

  const factory ForgottenPasswordPageState.inProgress() = _InProgress;

  const factory ForgottenPasswordPageState.successful() = _Successful;

  const factory ForgottenPasswordPageState.error({required ForgottenPasswordError error, required String email}) = _Error;
}
