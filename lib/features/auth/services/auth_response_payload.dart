

import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response_payload.g.dart';

@JsonSerializable()
class AuthResponsePayload {
  final String localId;
  final String idToken;
  final String refreshToken;
  final String expiresIn;

  AuthResponsePayload(this.localId, this.idToken, this.refreshToken, this.expiresIn);

  factory AuthResponsePayload.fromJson(Map<String, dynamic> json) => _$AuthResponsePayloadFromJson(json);
}