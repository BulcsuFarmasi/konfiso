// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_response_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RefreshTokenResponsePayload _$$_RefreshTokenResponsePayloadFromJson(
        Map<String, dynamic> json) =>
    _$_RefreshTokenResponsePayload(
      json['user_id'] as String,
      json['id_token'] as String,
      json['refresh_token'] as String,
      json['expires_in'] as String,
    );

Map<String, dynamic> _$$_RefreshTokenResponsePayloadToJson(
        _$_RefreshTokenResponsePayload instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'id_token': instance.id_token,
      'refresh_token': instance.refresh_token,
      'expires_in': instance.expires_in,
    };
