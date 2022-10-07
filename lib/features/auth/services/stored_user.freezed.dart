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
      _$StoredUserCopyWithImpl<$Res>;
  $Res call(
      {String userId, String token, String refreshToken, DateTime validUntil});
}

/// @nodoc
class _$StoredUserCopyWithImpl<$Res> implements $StoredUserCopyWith<$Res> {
  _$StoredUserCopyWithImpl(this._value, this._then);

  final StoredUser _value;
  // ignore: unused_field
  final $Res Function(StoredUser) _then;

  @override
  $Res call({
    Object? userId = freezed,
    Object? token = freezed,
    Object? refreshToken = freezed,
    Object? validUntil = freezed,
  }) {
    return _then(_value.copyWith(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: refreshToken == freezed
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      validUntil: validUntil == freezed
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$$_StoredUserCopyWith<$Res>
    implements $StoredUserCopyWith<$Res> {
  factory _$$_StoredUserCopyWith(
          _$_StoredUser value, $Res Function(_$_StoredUser) then) =
      __$$_StoredUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String userId, String token, String refreshToken, DateTime validUntil});
}

/// @nodoc
class __$$_StoredUserCopyWithImpl<$Res> extends _$StoredUserCopyWithImpl<$Res>
    implements _$$_StoredUserCopyWith<$Res> {
  __$$_StoredUserCopyWithImpl(
      _$_StoredUser _value, $Res Function(_$_StoredUser) _then)
      : super(_value, (v) => _then(v as _$_StoredUser));

  @override
  _$_StoredUser get _value => super._value as _$_StoredUser;

  @override
  $Res call({
    Object? userId = freezed,
    Object? token = freezed,
    Object? refreshToken = freezed,
    Object? validUntil = freezed,
  }) {
    return _then(_$_StoredUser(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: refreshToken == freezed
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      validUntil: validUntil == freezed
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
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.token, token) &&
            const DeepCollectionEquality()
                .equals(other.refreshToken, refreshToken) &&
            const DeepCollectionEquality()
                .equals(other.validUntil, validUntil));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(token),
      const DeepCollectionEquality().hash(refreshToken),
      const DeepCollectionEquality().hash(validUntil));

  @JsonKey(ignore: true)
  @override
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
