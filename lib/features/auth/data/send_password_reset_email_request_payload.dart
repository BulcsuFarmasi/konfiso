import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_password_reset_email_request_payload.freezed.dart';
part 'send_password_reset_email_request_payload.g.dart';

@freezed
class SendPasswordResetEmailRequestPayload with _$SendPasswordResetEmailRequestPayload {
  const factory SendPasswordResetEmailRequestPayload(String email, [@Default('PASSWORD_RESET') String requestType]) =
      _SendPasswordResetEmailRequestPayload;

  factory SendPasswordResetEmailRequestPayload.fromJson(Map<String, Object?> json) =>
      _$SendPasswordResetEmailRequestPayloadFromJson(json);
}
