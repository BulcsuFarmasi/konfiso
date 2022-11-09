// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'remote_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RemoteUser _$RemoteUserFromJson(Map<String, dynamic> json) {
  return _RemoteUser.fromJson(json);
}

/// @nodoc
mixin _$RemoteUser {
  String? get id => throw _privateConstructorUsedError;
  String get authId => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  DateTime get registrationDate => throw _privateConstructorUsedError;
  bool get consented => throw _privateConstructorUsedError;
  String get consentUrl => throw _privateConstructorUsedError;
  DateTime? get latestLogin => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RemoteUserCopyWith<RemoteUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemoteUserCopyWith<$Res> {
  factory $RemoteUserCopyWith(
          RemoteUser value, $Res Function(RemoteUser) then) =
      _$RemoteUserCopyWithImpl<$Res, RemoteUser>;
  @useResult
  $Res call(
      {String? id,
      String authId,
      String email,
      DateTime registrationDate,
      bool consented,
      String consentUrl,
      DateTime? latestLogin});
}

/// @nodoc
class _$RemoteUserCopyWithImpl<$Res, $Val extends RemoteUser>
    implements $RemoteUserCopyWith<$Res> {
  _$RemoteUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? authId = null,
    Object? email = null,
    Object? registrationDate = null,
    Object? consented = null,
    Object? consentUrl = null,
    Object? latestLogin = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      authId: null == authId
          ? _value.authId
          : authId // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      registrationDate: null == registrationDate
          ? _value.registrationDate
          : registrationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      consented: null == consented
          ? _value.consented
          : consented // ignore: cast_nullable_to_non_nullable
              as bool,
      consentUrl: null == consentUrl
          ? _value.consentUrl
          : consentUrl // ignore: cast_nullable_to_non_nullable
              as String,
      latestLogin: freezed == latestLogin
          ? _value.latestLogin
          : latestLogin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RemoteUserCopyWith<$Res>
    implements $RemoteUserCopyWith<$Res> {
  factory _$$_RemoteUserCopyWith(
          _$_RemoteUser value, $Res Function(_$_RemoteUser) then) =
      __$$_RemoteUserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String authId,
      String email,
      DateTime registrationDate,
      bool consented,
      String consentUrl,
      DateTime? latestLogin});
}

/// @nodoc
class __$$_RemoteUserCopyWithImpl<$Res>
    extends _$RemoteUserCopyWithImpl<$Res, _$_RemoteUser>
    implements _$$_RemoteUserCopyWith<$Res> {
  __$$_RemoteUserCopyWithImpl(
      _$_RemoteUser _value, $Res Function(_$_RemoteUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? authId = null,
    Object? email = null,
    Object? registrationDate = null,
    Object? consented = null,
    Object? consentUrl = null,
    Object? latestLogin = freezed,
  }) {
    return _then(_$_RemoteUser(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      authId: null == authId
          ? _value.authId
          : authId // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      registrationDate: null == registrationDate
          ? _value.registrationDate
          : registrationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      consented: null == consented
          ? _value.consented
          : consented // ignore: cast_nullable_to_non_nullable
              as bool,
      consentUrl: null == consentUrl
          ? _value.consentUrl
          : consentUrl // ignore: cast_nullable_to_non_nullable
              as String,
      latestLogin: freezed == latestLogin
          ? _value.latestLogin
          : latestLogin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RemoteUser implements _RemoteUser {
  const _$_RemoteUser(
      {this.id,
      required this.authId,
      required this.email,
      required this.registrationDate,
      required this.consented,
      required this.consentUrl,
      this.latestLogin});

  factory _$_RemoteUser.fromJson(Map<String, dynamic> json) =>
      _$$_RemoteUserFromJson(json);

  @override
  final String? id;
  @override
  final String authId;
  @override
  final String email;
  @override
  final DateTime registrationDate;
  @override
  final bool consented;
  @override
  final String consentUrl;
  @override
  final DateTime? latestLogin;

  @override
  String toString() {
    return 'RemoteUser(id: $id, authId: $authId, email: $email, registrationDate: $registrationDate, consented: $consented, consentUrl: $consentUrl, latestLogin: $latestLogin)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RemoteUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.authId, authId) || other.authId == authId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.registrationDate, registrationDate) ||
                other.registrationDate == registrationDate) &&
            (identical(other.consented, consented) ||
                other.consented == consented) &&
            (identical(other.consentUrl, consentUrl) ||
                other.consentUrl == consentUrl) &&
            (identical(other.latestLogin, latestLogin) ||
                other.latestLogin == latestLogin));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, authId, email,
      registrationDate, consented, consentUrl, latestLogin);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RemoteUserCopyWith<_$_RemoteUser> get copyWith =>
      __$$_RemoteUserCopyWithImpl<_$_RemoteUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RemoteUserToJson(
      this,
    );
  }
}

abstract class _RemoteUser implements RemoteUser {
  const factory _RemoteUser(
      {final String? id,
      required final String authId,
      required final String email,
      required final DateTime registrationDate,
      required final bool consented,
      required final String consentUrl,
      final DateTime? latestLogin}) = _$_RemoteUser;

  factory _RemoteUser.fromJson(Map<String, dynamic> json) =
      _$_RemoteUser.fromJson;

  @override
  String? get id;
  @override
  String get authId;
  @override
  String get email;
  @override
  DateTime get registrationDate;
  @override
  bool get consented;
  @override
  String get consentUrl;
  @override
  DateTime? get latestLogin;
  @override
  @JsonKey(ignore: true)
  _$$_RemoteUserCopyWith<_$_RemoteUser> get copyWith =>
      throw _privateConstructorUsedError;
}
