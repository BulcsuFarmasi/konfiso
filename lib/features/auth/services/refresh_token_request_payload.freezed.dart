// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'refresh_token_request_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RefreshTokenRequestPayload _$RefreshTokenRequestPayloadFromJson(
    Map<String, dynamic> json) {
  return _RefreshTokenRequestPayload.fromJson(json);
}

/// @nodoc
mixin _$RefreshTokenRequestPayload {
  String get refresh_token => throw _privateConstructorUsedError;
  String get grant_type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RefreshTokenRequestPayloadCopyWith<RefreshTokenRequestPayload>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RefreshTokenRequestPayloadCopyWith<$Res> {
  factory $RefreshTokenRequestPayloadCopyWith(RefreshTokenRequestPayload value,
          $Res Function(RefreshTokenRequestPayload) then) =
      _$RefreshTokenRequestPayloadCopyWithImpl<$Res,
          RefreshTokenRequestPayload>;
  @useResult
  $Res call({String refresh_token, String grant_type});
}

/// @nodoc
class _$RefreshTokenRequestPayloadCopyWithImpl<$Res,
        $Val extends RefreshTokenRequestPayload>
    implements $RefreshTokenRequestPayloadCopyWith<$Res> {
  _$RefreshTokenRequestPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? refresh_token = null,
    Object? grant_type = null,
  }) {
    return _then(_value.copyWith(
      refresh_token: null == refresh_token
          ? _value.refresh_token
          : refresh_token // ignore: cast_nullable_to_non_nullable
              as String,
      grant_type: null == grant_type
          ? _value.grant_type
          : grant_type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RefreshTokenRequestPayloadCopyWith<$Res>
    implements $RefreshTokenRequestPayloadCopyWith<$Res> {
  factory _$$_RefreshTokenRequestPayloadCopyWith(
          _$_RefreshTokenRequestPayload value,
          $Res Function(_$_RefreshTokenRequestPayload) then) =
      __$$_RefreshTokenRequestPayloadCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String refresh_token, String grant_type});
}

/// @nodoc
class __$$_RefreshTokenRequestPayloadCopyWithImpl<$Res>
    extends _$RefreshTokenRequestPayloadCopyWithImpl<$Res,
        _$_RefreshTokenRequestPayload>
    implements _$$_RefreshTokenRequestPayloadCopyWith<$Res> {
  __$$_RefreshTokenRequestPayloadCopyWithImpl(
      _$_RefreshTokenRequestPayload _value,
      $Res Function(_$_RefreshTokenRequestPayload) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? refresh_token = null,
    Object? grant_type = null,
  }) {
    return _then(_$_RefreshTokenRequestPayload(
      null == refresh_token
          ? _value.refresh_token
          : refresh_token // ignore: cast_nullable_to_non_nullable
              as String,
      null == grant_type
          ? _value.grant_type
          : grant_type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RefreshTokenRequestPayload implements _RefreshTokenRequestPayload {
  const _$_RefreshTokenRequestPayload(this.refresh_token,
      [this.grant_type = 'refresh_token']);

  factory _$_RefreshTokenRequestPayload.fromJson(Map<String, dynamic> json) =>
      _$$_RefreshTokenRequestPayloadFromJson(json);

  @override
  final String refresh_token;
  @override
  @JsonKey()
  final String grant_type;

  @override
  String toString() {
    return 'RefreshTokenRequestPayload(refresh_token: $refresh_token, grant_type: $grant_type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RefreshTokenRequestPayload &&
            (identical(other.refresh_token, refresh_token) ||
                other.refresh_token == refresh_token) &&
            (identical(other.grant_type, grant_type) ||
                other.grant_type == grant_type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, refresh_token, grant_type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RefreshTokenRequestPayloadCopyWith<_$_RefreshTokenRequestPayload>
      get copyWith => __$$_RefreshTokenRequestPayloadCopyWithImpl<
          _$_RefreshTokenRequestPayload>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RefreshTokenRequestPayloadToJson(
      this,
    );
  }
}

abstract class _RefreshTokenRequestPayload
    implements RefreshTokenRequestPayload {
  const factory _RefreshTokenRequestPayload(final String refresh_token,
      [final String grant_type]) = _$_RefreshTokenRequestPayload;

  factory _RefreshTokenRequestPayload.fromJson(Map<String, dynamic> json) =
      _$_RefreshTokenRequestPayload.fromJson;

  @override
  String get refresh_token;
  @override
  String get grant_type;
  @override
  @JsonKey(ignore: true)
  _$$_RefreshTokenRequestPayloadCopyWith<_$_RefreshTokenRequestPayload>
      get copyWith => throw _privateConstructorUsedError;
}
