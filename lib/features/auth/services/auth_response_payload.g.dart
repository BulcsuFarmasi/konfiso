// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponsePayload _$AuthResponsePayloadFromJson(Map<String, dynamic> json) =>
    AuthResponsePayload(
      json['localId'] as String,
      json['idToken'] as String,
      json['refreshToken'] as String,
      json['expiresIn'] as String,
    );

Map<String, dynamic> _$AuthResponsePayloadToJson(
        AuthResponsePayload instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'idToken': instance.idToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
    };
