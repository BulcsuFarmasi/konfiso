import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_payload.g.dart';

@JsonSerializable()
class AuthPayload {
  final String email;
  final String password;
  final bool returnSecureToken;

  AuthPayload(this.email, this.password, [this.returnSecureToken = true]);

  Map<String, dynamic> toJson() => _$AuthPayloadToJson(this);
}