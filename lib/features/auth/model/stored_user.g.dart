// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stored_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StoredUser _$$_StoredUserFromJson(Map<String, dynamic> json) =>
    _$_StoredUser(
      userId: json['userId'] as String,
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
      validUntil: DateTime.parse(json['validUntil'] as String),
    );

Map<String, dynamic> _$$_StoredUserToJson(_$_StoredUser instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'validUntil': instance.validUntil.toIso8601String(),
    };
