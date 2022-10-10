// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_token_payload.g.dart';

@JsonSerializable()
class RefreshTokenPayload {
  final String refresh_token;
  final String grant_type;
  RefreshTokenPayload(this.refresh_token, [this.grant_type = 'refresh_token']);

  Map<String, dynamic> toJson() => _$RefreshTokenPayloadToJson(this);
}