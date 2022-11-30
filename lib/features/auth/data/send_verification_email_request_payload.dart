import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_verification_email_request_payload.freezed.dart';
part 'send_verification_email_request_payload.g.dart';

@freezed
class SendVerificationEmailPayload with _$SendVerificationEmailPayload {
  const factory SendVerificationEmailPayload({required String idToken, @Default('VERIFY_EMAIL') String requestType}) =
      _SendVerificationEmailPayload;

  factory SendVerificationEmailPayload.fromJson(Map<String, Object?> json) =>
      _$SendVerificationEmailPayloadFromJson(json);
}
