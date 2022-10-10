// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_request_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenRequestPayload _$RefreshTokenRequestPayloadFromJson(
        Map<String, dynamic> json) =>
    RefreshTokenRequestPayload(
      json['refresh_token'] as String,
      json['grant_type'] as String? ?? 'refresh_token',
    );

Map<String, dynamic> _$RefreshTokenRequestPayloadToJson(
        RefreshTokenRequestPayload instance) =>
    <String, dynamic>{
      'refresh_token': instance.refresh_token,
      'grant_type': instance.grant_type,
    };
