// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_request_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthRequestPayload _$AuthRequestPayloadFromJson(Map<String, dynamic> json) =>
    AuthRequestPayload(
      json['email'] as String,
      json['password'] as String,
      json['returnSecureToken'] as bool? ?? true,
    );

Map<String, dynamic> _$AuthRequestPayloadToJson(AuthRequestPayload instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'returnSecureToken': instance.returnSecureToken,
    };
