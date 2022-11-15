// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_token_response_payload.freezed.dart';
part 'refresh_token_response_payload.g.dart';

@freezed
class RefreshTokenResponsePayload with _$RefreshTokenResponsePayload {


  const factory RefreshTokenResponsePayload(
  String user_id,
  String id_token,
  String refresh_token,
  String expires_in,
  ) = _RefreshTokenResponsePayload;

  factory RefreshTokenResponsePayload.fromJson(Map<String, Object?> json) =>
      _$RefreshTokenResponsePayloadFromJson(json);
}
