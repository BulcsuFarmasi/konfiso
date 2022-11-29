import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response_payload.freezed.dart';

part 'auth_response_payload.g.dart';

@freezed
class AuthResponsePayload with _$AuthResponsePayload {

  const factory AuthResponsePayload(String localId,
      String idToken,
      String refreshToken,
      String expiresIn,
      {String? userId}) = _AuthResponePayload;

  factory AuthResponsePayload.fromJson(Map<String, Object?> json) =>
      _$AuthResponsePayloadFromJson(json);
}
