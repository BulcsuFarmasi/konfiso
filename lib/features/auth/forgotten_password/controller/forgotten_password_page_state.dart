import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/auth/forgotten_password/model/forgotten_password_error.dart';

part 'forgotten_password_page_state.freezed.dart';

@freezed
sealed class ForgottenPasswordPageState with _$ForgottenPasswordPageState {
  const factory ForgottenPasswordPageState.initial() = Initial;

  const factory ForgottenPasswordPageState.inProgress() = InProgress;

  const factory ForgottenPasswordPageState.successful() = Successful;

  const factory ForgottenPasswordPageState.error({required ForgottenPasswordError error, required String email}) =
      Error;
}
