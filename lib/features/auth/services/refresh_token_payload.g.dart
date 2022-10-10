// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenPayload _$RefreshTokenPayloadFromJson(Map<String, dynamic> json) =>
    RefreshTokenPayload(
      json['refresh_token'] as String,
      json['grant_type'] as String? ?? 'refresh_token',
    );

Map<String, dynamic> _$RefreshTokenPayloadToJson(
        RefreshTokenPayload instance) =>
    <String, dynamic>{
      'refresh_token': instance.refresh_token,
      'grant_type': instance.grant_type,
    };
