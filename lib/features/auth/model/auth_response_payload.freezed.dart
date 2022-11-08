// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth_response_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AuthResponsePayload _$AuthResponsePayloadFromJson(Map<String, dynamic> json) {
  return _AuthResponePayload.fromJson(json);
}

/// @nodoc
mixin _$AuthResponsePayload {
  String get localId => throw _privateConstructorUsedError;
  String get idToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;
  String get expiresIn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthResponsePayloadCopyWith<AuthResponsePayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthResponsePayloadCopyWith<$Res> {
  factory $AuthResponsePayloadCopyWith(
          AuthResponsePayload value, $Res Function(AuthResponsePayload) then) =
      _$AuthResponsePayloadCopyWithImpl<$Res, AuthResponsePayload>;
  @useResult
  $Res call(
      {String localId, String idToken, String refreshToken, String expiresIn});
}

/// @nodoc
class _$AuthResponsePayloadCopyWithImpl<$Res, $Val extends AuthResponsePayload>
    implements $AuthResponsePayloadCopyWith<$Res> {
  _$AuthResponsePayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localId = null,
    Object? idToken = null,
    Object? refreshToken = null,
    Object? expiresIn = null,
  }) {
    return _then(_value.copyWith(
      localId: null == localId
          ? _value.localId
          : localId // ignore: cast_nullable_to_non_nullable
              as String,
      idToken: null == idToken
          ? _value.idToken
          : idToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AuthResponePayloadCopyWith<$Res>
    implements $AuthResponsePayloadCopyWith<$Res> {
  factory _$$_AuthResponePayloadCopyWith(_$_AuthResponePayload value,
          $Res Function(_$_AuthResponePayload) then) =
      __$$_AuthResponePayloadCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String localId, String idToken, String refreshToken, String expiresIn});
}

/// @nodoc
class __$$_AuthResponePayloadCopyWithImpl<$Res>
    extends _$AuthResponsePayloadCopyWithImpl<$Res, _$_AuthResponePayload>
    implements _$$_AuthResponePayloadCopyWith<$Res> {
  __$$_AuthResponePayloadCopyWithImpl(
      _$_AuthResponePayload _value, $Res Function(_$_AuthResponePayload) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localId = null,
    Object? idToken = null,
    Object? refreshToken = null,
    Object? expiresIn = null,
  }) {
    return _then(_$_AuthResponePayload(
      null == localId
          ? _value.localId
          : localId // ignore: cast_nullable_to_non_nullable
              as String,
      null == idToken
          ? _value.idToken
          : idToken // ignore: cast_nullable_to_non_nullable
              as String,
      null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      null == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AuthResponePayload implements _AuthResponePayload {
  const _$_AuthResponePayload(
      this.localId, this.idToken, this.refreshToken, this.expiresIn);

  factory _$_AuthResponePayload.fromJson(Map<String, dynamic> json) =>
      _$$_AuthResponePayloadFromJson(json);

  @override
  final String localId;
  @override
  final String idToken;
  @override
  final String refreshToken;
  @override
  final String expiresIn;

  @override
  String toString() {
    return 'AuthResponsePayload(localId: $localId, idToken: $idToken, refreshToken: $refreshToken, expiresIn: $expiresIn)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthResponePayload &&
            (identical(other.localId, localId) || other.localId == localId) &&
            (identical(other.idToken, idToken) || other.idToken == idToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, localId, idToken, refreshToken, expiresIn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthResponePayloadCopyWith<_$_AuthResponePayload> get copyWith =>
      __$$_AuthResponePayloadCopyWithImpl<_$_AuthResponePayload>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AuthResponePayloadToJson(
      this,
    );
  }
}

abstract class _AuthResponePayload implements AuthResponsePayload {
  const factory _AuthResponePayload(
      final String localId,
      final String idToken,
      final String refreshToken,
      final String expiresIn) = _$_AuthResponePayload;

  factory _AuthResponePayload.fromJson(Map<String, dynamic> json) =
      _$_AuthResponePayload.fromJson;

  @override
  String get localId;
  @override
  String get idToken;
  @override
  String get refreshToken;
  @override
  String get expiresIn;
  @override
  @JsonKey(ignore: true)
  _$$_AuthResponePayloadCopyWith<_$_AuthResponePayload> get copyWith =>
      throw _privateConstructorUsedError;
}
