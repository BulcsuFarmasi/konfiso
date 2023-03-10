// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sign_up_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SignUpPageState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String privacyPolicyUrl) initial,
    required TResult Function() inProgress,
    required TResult Function() successful,
    required TResult Function(SignUpError error, String privacyPolicyUrl) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String privacyPolicyUrl)? initial,
    TResult? Function()? inProgress,
    TResult? Function()? successful,
    TResult? Function(SignUpError error, String privacyPolicyUrl)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String privacyPolicyUrl)? initial,
    TResult Function()? inProgress,
    TResult Function()? successful,
    TResult Function(SignUpError error, String privacyPolicyUrl)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Succesful value) successful,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Succesful value)? successful,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Succesful value)? successful,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpPageStateCopyWith<$Res> {
  factory $SignUpPageStateCopyWith(SignUpPageState value, $Res Function(SignUpPageState) then) =
      _$SignUpPageStateCopyWithImpl<$Res, SignUpPageState>;
}

/// @nodoc
class _$SignUpPageStateCopyWithImpl<$Res, $Val extends SignUpPageState> implements $SignUpPageStateCopyWith<$Res> {
  _$SignUpPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res> {
  factory _$$_InitialCopyWith(_$_Initial value, $Res Function(_$_Initial) then) = __$$_InitialCopyWithImpl<$Res>;
  @useResult
  $Res call({String privacyPolicyUrl});
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res> extends _$SignUpPageStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? privacyPolicyUrl = null,
  }) {
    return _then(_$_Initial(
      null == privacyPolicyUrl
          ? _value.privacyPolicyUrl
          : privacyPolicyUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial(this.privacyPolicyUrl);

  @override
  final String privacyPolicyUrl;

  @override
  String toString() {
    return 'SignUpPageState.initial(privacyPolicyUrl: $privacyPolicyUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Initial &&
            (identical(other.privacyPolicyUrl, privacyPolicyUrl) || other.privacyPolicyUrl == privacyPolicyUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, privacyPolicyUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InitialCopyWith<_$_Initial> get copyWith => __$$_InitialCopyWithImpl<_$_Initial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String privacyPolicyUrl) initial,
    required TResult Function() inProgress,
    required TResult Function() successful,
    required TResult Function(SignUpError error, String privacyPolicyUrl) error,
  }) {
    return initial(privacyPolicyUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String privacyPolicyUrl)? initial,
    TResult? Function()? inProgress,
    TResult? Function()? successful,
    TResult? Function(SignUpError error, String privacyPolicyUrl)? error,
  }) {
    return initial?.call(privacyPolicyUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String privacyPolicyUrl)? initial,
    TResult Function()? inProgress,
    TResult Function()? successful,
    TResult Function(SignUpError error, String privacyPolicyUrl)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(privacyPolicyUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Succesful value) successful,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Succesful value)? successful,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Succesful value)? successful,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements SignUpPageState {
  const factory _Initial(final String privacyPolicyUrl) = _$_Initial;

  String get privacyPolicyUrl;
  @JsonKey(ignore: true)
  _$$_InitialCopyWith<_$_Initial> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_InProgressCopyWith<$Res> {
  factory _$$_InProgressCopyWith(_$_InProgress value, $Res Function(_$_InProgress) then) =
      __$$_InProgressCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InProgressCopyWithImpl<$Res> extends _$SignUpPageStateCopyWithImpl<$Res, _$_InProgress>
    implements _$$_InProgressCopyWith<$Res> {
  __$$_InProgressCopyWithImpl(_$_InProgress _value, $Res Function(_$_InProgress) _then) : super(_value, _then);
}

/// @nodoc

class _$_InProgress implements _InProgress {
  const _$_InProgress();

  @override
  String toString() {
    return 'SignUpPageState.inProgress()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$_InProgress);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String privacyPolicyUrl) initial,
    required TResult Function() inProgress,
    required TResult Function() successful,
    required TResult Function(SignUpError error, String privacyPolicyUrl) error,
  }) {
    return inProgress();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String privacyPolicyUrl)? initial,
    TResult? Function()? inProgress,
    TResult? Function()? successful,
    TResult? Function(SignUpError error, String privacyPolicyUrl)? error,
  }) {
    return inProgress?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String privacyPolicyUrl)? initial,
    TResult Function()? inProgress,
    TResult Function()? successful,
    TResult Function(SignUpError error, String privacyPolicyUrl)? error,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Succesful value) successful,
    required TResult Function(_Error value) error,
  }) {
    return inProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Succesful value)? successful,
    TResult? Function(_Error value)? error,
  }) {
    return inProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Succesful value)? successful,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress(this);
    }
    return orElse();
  }
}

abstract class _InProgress implements SignUpPageState {
  const factory _InProgress() = _$_InProgress;
}

/// @nodoc
abstract class _$$_SuccesfulCopyWith<$Res> {
  factory _$$_SuccesfulCopyWith(_$_Succesful value, $Res Function(_$_Succesful) then) =
      __$$_SuccesfulCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_SuccesfulCopyWithImpl<$Res> extends _$SignUpPageStateCopyWithImpl<$Res, _$_Succesful>
    implements _$$_SuccesfulCopyWith<$Res> {
  __$$_SuccesfulCopyWithImpl(_$_Succesful _value, $Res Function(_$_Succesful) _then) : super(_value, _then);
}

/// @nodoc

class _$_Succesful implements _Succesful {
  const _$_Succesful();

  @override
  String toString() {
    return 'SignUpPageState.successful()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$_Succesful);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String privacyPolicyUrl) initial,
    required TResult Function() inProgress,
    required TResult Function() successful,
    required TResult Function(SignUpError error, String privacyPolicyUrl) error,
  }) {
    return successful();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String privacyPolicyUrl)? initial,
    TResult? Function()? inProgress,
    TResult? Function()? successful,
    TResult? Function(SignUpError error, String privacyPolicyUrl)? error,
  }) {
    return successful?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String privacyPolicyUrl)? initial,
    TResult Function()? inProgress,
    TResult Function()? successful,
    TResult Function(SignUpError error, String privacyPolicyUrl)? error,
    required TResult orElse(),
  }) {
    if (successful != null) {
      return successful();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Succesful value) successful,
    required TResult Function(_Error value) error,
  }) {
    return successful(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Succesful value)? successful,
    TResult? Function(_Error value)? error,
  }) {
    return successful?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Succesful value)? successful,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (successful != null) {
      return successful(this);
    }
    return orElse();
  }
}

abstract class _Succesful implements SignUpPageState {
  const factory _Succesful() = _$_Succesful;
}

/// @nodoc
abstract class _$$_ErrorCopyWith<$Res> {
  factory _$$_ErrorCopyWith(_$_Error value, $Res Function(_$_Error) then) = __$$_ErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({SignUpError error, String privacyPolicyUrl});
}

/// @nodoc
class __$$_ErrorCopyWithImpl<$Res> extends _$SignUpPageStateCopyWithImpl<$Res, _$_Error>
    implements _$$_ErrorCopyWith<$Res> {
  __$$_ErrorCopyWithImpl(_$_Error _value, $Res Function(_$_Error) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? privacyPolicyUrl = null,
  }) {
    return _then(_$_Error(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as SignUpError,
      null == privacyPolicyUrl
          ? _value.privacyPolicyUrl
          : privacyPolicyUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Error implements _Error {
  const _$_Error(this.error, this.privacyPolicyUrl);

  @override
  final SignUpError error;
  @override
  final String privacyPolicyUrl;

  @override
  String toString() {
    return 'SignUpPageState.error(error: $error, privacyPolicyUrl: $privacyPolicyUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Error &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.privacyPolicyUrl, privacyPolicyUrl) || other.privacyPolicyUrl == privacyPolicyUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error, privacyPolicyUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ErrorCopyWith<_$_Error> get copyWith => __$$_ErrorCopyWithImpl<_$_Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String privacyPolicyUrl) initial,
    required TResult Function() inProgress,
    required TResult Function() successful,
    required TResult Function(SignUpError error, String privacyPolicyUrl) error,
  }) {
    return error(this.error, privacyPolicyUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String privacyPolicyUrl)? initial,
    TResult? Function()? inProgress,
    TResult? Function()? successful,
    TResult? Function(SignUpError error, String privacyPolicyUrl)? error,
  }) {
    return error?.call(this.error, privacyPolicyUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String privacyPolicyUrl)? initial,
    TResult Function()? inProgress,
    TResult Function()? successful,
    TResult Function(SignUpError error, String privacyPolicyUrl)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error, privacyPolicyUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Succesful value) successful,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Succesful value)? successful,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Succesful value)? successful,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements SignUpPageState {
  const factory _Error(final SignUpError error, final String privacyPolicyUrl) = _$_Error;

  SignUpError get error;
  String get privacyPolicyUrl;
  @JsonKey(ignore: true)
  _$$_ErrorCopyWith<_$_Error> get copyWith => throw _privateConstructorUsedError;
}
