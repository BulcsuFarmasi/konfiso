// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'refresh_token_response_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RefreshTokenResponsePayload _$RefreshTokenResponsePayloadFromJson(
    Map<String, dynamic> json) {
  return _RefreshTokenResponsePayload.fromJson(json);
}

/// @nodoc
mixin _$RefreshTokenResponsePayload {
  String get user_id => throw _privateConstructorUsedError;
  String get id_token => throw _privateConstructorUsedError;
  String get refresh_token => throw _privateConstructorUsedError;
  String get expires_in => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RefreshTokenResponsePayloadCopyWith<RefreshTokenResponsePayload>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RefreshTokenResponsePayloadCopyWith<$Res> {
  factory $RefreshTokenResponsePayloadCopyWith(
          RefreshTokenResponsePayload value,
          $Res Function(RefreshTokenResponsePayload) then) =
      _$RefreshTokenResponsePayloadCopyWithImpl<$Res,
          RefreshTokenResponsePayload>;
  @useResult
  $Res call(
      {String user_id,
      String id_token,
      String refresh_token,
      String expires_in});
}

/// @nodoc
class _$RefreshTokenResponsePayloadCopyWithImpl<$Res,
        $Val extends RefreshTokenResponsePayload>
    implements $RefreshTokenResponsePayloadCopyWith<$Res> {
  _$RefreshTokenResponsePayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user_id = null,
    Object? id_token = null,
    Object? refresh_token = null,
    Object? expires_in = null,
  }) {
    return _then(_value.copyWith(
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
      id_token: null == id_token
          ? _value.id_token
          : id_token // ignore: cast_nullable_to_non_nullable
              as String,
      refresh_token: null == refresh_token
          ? _value.refresh_token
          : refresh_token // ignore: cast_nullable_to_non_nullable
              as String,
      expires_in: null == expires_in
          ? _value.expires_in
          : expires_in // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RefreshTokenResponsePayloadCopyWith<$Res>
    implements $RefreshTokenResponsePayloadCopyWith<$Res> {
  factory _$$_RefreshTokenResponsePayloadCopyWith(
          _$_RefreshTokenResponsePayload value,
          $Res Function(_$_RefreshTokenResponsePayload) then) =
      __$$_RefreshTokenResponsePayloadCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String user_id,
      String id_token,
      String refresh_token,
      String expires_in});
}

/// @nodoc
class __$$_RefreshTokenResponsePayloadCopyWithImpl<$Res>
    extends _$RefreshTokenResponsePayloadCopyWithImpl<$Res,
        _$_RefreshTokenResponsePayload>
    implements _$$_RefreshTokenResponsePayloadCopyWith<$Res> {
  __$$_RefreshTokenResponsePayloadCopyWithImpl(
      _$_RefreshTokenResponsePayload _value,
      $Res Function(_$_RefreshTokenResponsePayload) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user_id = null,
    Object? id_token = null,
    Object? refresh_token = null,
    Object? expires_in = null,
  }) {
    return _then(_$_RefreshTokenResponsePayload(
      null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
      null == id_token
          ? _value.id_token
          : id_token // ignore: cast_nullable_to_non_nullable
              as String,
      null == refresh_token
          ? _value.refresh_token
          : refresh_token // ignore: cast_nullable_to_non_nullable
              as String,
      null == expires_in
          ? _value.expires_in
          : expires_in // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RefreshTokenResponsePayload implements _RefreshTokenResponsePayload {
  const _$_RefreshTokenResponsePayload(
      this.user_id, this.id_token, this.refresh_token, this.expires_in);

  factory _$_RefreshTokenResponsePayload.fromJson(Map<String, dynamic> json) =>
      _$$_RefreshTokenResponsePayloadFromJson(json);

  @override
  final String user_id;
  @override
  final String id_token;
  @override
  final String refresh_token;
  @override
  final String expires_in;

  @override
  String toString() {
    return 'RefreshTokenResponsePayload(user_id: $user_id, id_token: $id_token, refresh_token: $refresh_token, expires_in: $expires_in)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RefreshTokenResponsePayload &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.id_token, id_token) ||
                other.id_token == id_token) &&
            (identical(other.refresh_token, refresh_token) ||
                other.refresh_token == refresh_token) &&
            (identical(other.expires_in, expires_in) ||
                other.expires_in == expires_in));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, user_id, id_token, refresh_token, expires_in);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RefreshTokenResponsePayloadCopyWith<_$_RefreshTokenResponsePayload>
      get copyWith => __$$_RefreshTokenResponsePayloadCopyWithImpl<
          _$_RefreshTokenResponsePayload>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RefreshTokenResponsePayloadToJson(
      this,
    );
  }
}

abstract class _RefreshTokenResponsePayload
    implements RefreshTokenResponsePayload {
  const factory _RefreshTokenResponsePayload(
      final String user_id,
      final String id_token,
      final String refresh_token,
      final String expires_in) = _$_RefreshTokenResponsePayload;

  factory _RefreshTokenResponsePayload.fromJson(Map<String, dynamic> json) =
      _$_RefreshTokenResponsePayload.fromJson;

  @override
  String get user_id;
  @override
  String get id_token;
  @override
  String get refresh_token;
  @override
  String get expires_in;
  @override
  @JsonKey(ignore: true)
  _$$_RefreshTokenResponsePayloadCopyWith<_$_RefreshTokenResponsePayload>
      get copyWith => throw _privateConstructorUsedError;
}
