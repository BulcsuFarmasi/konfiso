// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_token_response_payload.g.dart';

@JsonSerializable()
class RefreshTokenResponsePayload {
  final String user_id;
  final String id_token;
  final String refresh_token;
  final String expires_in;

  RefreshTokenResponsePayload(
    this.refresh_token,
    this.user_id,
    this.id_token,
    this.expires_in,
  );

  factory RefreshTokenResponsePayload.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponsePayloadFromJson(json)
      _$RefreshTokenResponsePayloadFromJson(json)
}
