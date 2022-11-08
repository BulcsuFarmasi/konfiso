// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'stored_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StoredUser _$StoredUserFromJson(Map<String, dynamic> json) {
  return _StoredUser.fromJson(json);
}

/// @nodoc
mixin _$StoredUser {
  String get userId => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;
  DateTime get validUntil => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoredUserCopyWith<StoredUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoredUserCopyWith<$Res> {
  factory $StoredUserCopyWith(
          StoredUser value, $Res Function(StoredUser) then) =
      _$StoredUserCopyWithImpl<$Res, StoredUser>;
  @useResult
  $Res call(
      {String userId, String token, String refreshToken, DateTime validUntil});
}

/// @nodoc
class _$StoredUserCopyWithImpl<$Res, $Val extends StoredUser>
    implements $StoredUserCopyWith<$Res> {
  _$StoredUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? token = null,
    Object? refreshToken = null,
    Object? validUntil = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      validUntil: null == validUntil
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StoredUserCopyWith<$Res>
    implements $StoredUserCopyWith<$Res> {
  factory _$$_StoredUserCopyWith(
          _$_StoredUser value, $Res Function(_$_StoredUser) then) =
      __$$_StoredUserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId, String token, String refreshToken, DateTime validUntil});
}

/// @nodoc
class __$$_StoredUserCopyWithImpl<$Res>
    extends _$StoredUserCopyWithImpl<$Res, _$_StoredUser>
    implements _$$_StoredUserCopyWith<$Res> {
  __$$_StoredUserCopyWithImpl(
      _$_StoredUser _value, $Res Function(_$_StoredUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? token = null,
    Object? refreshToken = null,
    Object? validUntil = null,
  }) {
    return _then(_$_StoredUser(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      validUntil: null == validUntil
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StoredUser implements _StoredUser {
  const _$_StoredUser(
      {required this.userId,
      required this.token,
      required this.refreshToken,
      required this.validUntil});

  factory _$_StoredUser.fromJson(Map<String, dynamic> json) =>
      _$$_StoredUserFromJson(json);

  @override
  final String userId;
  @override
  final String token;
  @override
  final String refreshToken;
  @override
  final DateTime validUntil;

  @override
  String toString() {
    return 'StoredUser(userId: $userId, token: $token, refreshToken: $refreshToken, validUntil: $validUntil)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StoredUser &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.validUntil, validUntil) ||
                other.validUntil == validUntil));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, token, refreshToken, validUntil);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StoredUserCopyWith<_$_StoredUser> get copyWith =>
      __$$_StoredUserCopyWithImpl<_$_StoredUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StoredUserToJson(
      this,
    );
  }
}

abstract class _StoredUser implements StoredUser {
  const factory _StoredUser(
      {required final String userId,
      required final String token,
      required final String refreshToken,
      required final DateTime validUntil}) = _$_StoredUser;

  factory _StoredUser.fromJson(Map<String, dynamic> json) =
      _$_StoredUser.fromJson;

  @override
  String get userId;
  @override
  String get token;
  @override
  String get refreshToken;
  @override
  DateTime get validUntil;
  @override
  @JsonKey(ignore: true)
  _$$_StoredUserCopyWith<_$_StoredUser> get copyWith =>
      throw _privateConstructorUsedError;
}
