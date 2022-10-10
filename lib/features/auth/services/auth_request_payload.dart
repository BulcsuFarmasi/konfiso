import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_request_payload.g.dart';

@JsonSerializable()
class AuthRequestPayload {
  final String email;
  final String password;
  final bool returnSecureToken;

  AuthRequestPayload(this.email, this.password, [this.returnSecureToken = true]);

  Map<String, dynamic> toJson() => _$AuthRequestPayloadToJson(this);
}