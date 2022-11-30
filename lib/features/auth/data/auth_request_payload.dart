import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_request_payload.freezed.dart';
part 'auth_request_payload.g.dart';

@freezed
class AuthRequestPayload with _$AuthRequestPayload {
  const factory AuthRequestPayload(
    String email,
    String password, [
    @Default(true) bool returnSecureToken,
  ]) = _AuthRequestPayload;

  factory AuthRequestPayload.fromJson(Map<String, Object?> json) => _$AuthRequestPayloadFromJson(json);
}
