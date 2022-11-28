// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_token_request_payload.freezed.dart';

part 'refresh_token_request_payload.g.dart';

@freezed
class RefreshTokenRequestPayload with _$RefreshTokenRequestPayload {


  const factory RefreshTokenRequestPayload(String refresh_token, [@Default(
      'refresh_token') String grant_type]) = _RefreshTokenRequestPayload;

  factory RefreshTokenRequestPayload.fromJson(Map<String, Object?> json) =>
      _$RefreshTokenRequestPayloadFromJson(json);
}
