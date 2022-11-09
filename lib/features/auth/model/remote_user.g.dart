// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RemoteUser _$$_RemoteUserFromJson(Map<String, dynamic> json) =>
    _$_RemoteUser(
      id: json['id'] as String?,
      authId: json['authId'] as String,
      email: json['email'] as String,
      registrationDate: DateTime.parse(json['registrationDate'] as String),
      consented: json['consented'] as bool,
      consentUrl: json['consentUrl'] as String,
      latestLogin: json['latestLogin'] == null
          ? null
          : DateTime.parse(json['latestLogin'] as String),
    );

Map<String, dynamic> _$$_RemoteUserToJson(_$_RemoteUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authId': instance.authId,
      'email': instance.email,
      'registrationDate': instance.registrationDate.toIso8601String(),
      'consented': instance.consented,
      'consentUrl': instance.consentUrl,
      'latestLogin': instance.latestLogin?.toIso8601String(),
    };
