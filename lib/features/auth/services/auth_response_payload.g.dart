// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AuthResponePayload _$$_AuthResponePayloadFromJson(
        Map<String, dynamic> json) =>
    _$_AuthResponePayload(
      json['localId'] as String,
      json['idToken'] as String,
      json['refreshToken'] as String,
      json['expiresIn'] as String,
    );

Map<String, dynamic> _$$_AuthResponePayloadToJson(
        _$_AuthResponePayload instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'idToken': instance.idToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
    };
