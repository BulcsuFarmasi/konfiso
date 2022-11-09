// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'book.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Book {
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get externalId => throw _privateConstructorUsedError;
  List<String>? get authors => throw _privateConstructorUsedError;
  int? get publicationYear => throw _privateConstructorUsedError;
  int? get isbn => throw _privateConstructorUsedError;
  String? get coverImageSmall => throw _privateConstructorUsedError;
  String? get coverImageLarge => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BookCopyWith<Book> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookCopyWith<$Res> {
  factory $BookCopyWith(Book value, $Res Function(Book) then) =
      _$BookCopyWithImpl<$Res, Book>;
  @useResult
  $Res call(
      {String? id,
      String title,
      String externalId,
      List<String>? authors,
      int? publicationYear,
      int? isbn,
      String? coverImageSmall,
      String? coverImageLarge});
}

/// @nodoc
class _$BookCopyWithImpl<$Res, $Val extends Book>
    implements $BookCopyWith<$Res> {
  _$BookCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? externalId = null,
    Object? authors = freezed,
    Object? publicationYear = freezed,
    Object? isbn = freezed,
    Object? coverImageSmall = freezed,
    Object? coverImageLarge = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      externalId: null == externalId
          ? _value.externalId
          : externalId // ignore: cast_nullable_to_non_nullable
              as String,
      authors: freezed == authors
          ? _value.authors
          : authors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      publicationYear: freezed == publicationYear
          ? _value.publicationYear
          : publicationYear // ignore: cast_nullable_to_non_nullable
              as int?,
      isbn: freezed == isbn
          ? _value.isbn
          : isbn // ignore: cast_nullable_to_non_nullable
              as int?,
      coverImageSmall: freezed == coverImageSmall
          ? _value.coverImageSmall
          : coverImageSmall // ignore: cast_nullable_to_non_nullable
              as String?,
      coverImageLarge: freezed == coverImageLarge
          ? _value.coverImageLarge
          : coverImageLarge // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BookCopyWith<$Res> implements $BookCopyWith<$Res> {
  factory _$$_BookCopyWith(_$_Book value, $Res Function(_$_Book) then) =
      __$$_BookCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String title,
      String externalId,
      List<String>? authors,
      int? publicationYear,
      int? isbn,
      String? coverImageSmall,
      String? coverImageLarge});
}

/// @nodoc
class __$$_BookCopyWithImpl<$Res> extends _$BookCopyWithImpl<$Res, _$_Book>
    implements _$$_BookCopyWith<$Res> {
  __$$_BookCopyWithImpl(_$_Book _value, $Res Function(_$_Book) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? externalId = null,
    Object? authors = freezed,
    Object? publicationYear = freezed,
    Object? isbn = freezed,
    Object? coverImageSmall = freezed,
    Object? coverImageLarge = freezed,
  }) {
    return _then(_$_Book(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      externalId: null == externalId
          ? _value.externalId
          : externalId // ignore: cast_nullable_to_non_nullable
              as String,
      authors: freezed == authors
          ? _value._authors
          : authors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      publicationYear: freezed == publicationYear
          ? _value.publicationYear
          : publicationYear // ignore: cast_nullable_to_non_nullable
              as int?,
      isbn: freezed == isbn
          ? _value.isbn
          : isbn // ignore: cast_nullable_to_non_nullable
              as int?,
      coverImageSmall: freezed == coverImageSmall
          ? _value.coverImageSmall
          : coverImageSmall // ignore: cast_nullable_to_non_nullable
              as String?,
      coverImageLarge: freezed == coverImageLarge
          ? _value.coverImageLarge
          : coverImageLarge // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_Book implements _Book {
  const _$_Book(
      {this.id,
      required this.title,
      required this.externalId,
      final List<String>? authors,
      this.publicationYear,
      this.isbn,
      this.coverImageSmall,
      this.coverImageLarge})
      : _authors = authors;

  @override
  final String? id;
  @override
  final String title;
  @override
  final String externalId;
  final List<String>? _authors;
  @override
  List<String>? get authors {
    final value = _authors;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? publicationYear;
  @override
  final int? isbn;
  @override
  final String? coverImageSmall;
  @override
  final String? coverImageLarge;

  @override
  String toString() {
    return 'Book(id: $id, title: $title, externalId: $externalId, authors: $authors, publicationYear: $publicationYear, isbn: $isbn, coverImageSmall: $coverImageSmall, coverImageLarge: $coverImageLarge)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Book &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.externalId, externalId) ||
                other.externalId == externalId) &&
            const DeepCollectionEquality().equals(other._authors, _authors) &&
            (identical(other.publicationYear, publicationYear) ||
                other.publicationYear == publicationYear) &&
            (identical(other.isbn, isbn) || other.isbn == isbn) &&
            (identical(other.coverImageSmall, coverImageSmall) ||
                other.coverImageSmall == coverImageSmall) &&
            (identical(other.coverImageLarge, coverImageLarge) ||
                other.coverImageLarge == coverImageLarge));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      externalId,
      const DeepCollectionEquality().hash(_authors),
      publicationYear,
      isbn,
      coverImageSmall,
      coverImageLarge);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BookCopyWith<_$_Book> get copyWith =>
      __$$_BookCopyWithImpl<_$_Book>(this, _$identity);
}

abstract class _Book implements Book {
  const factory _Book(
      {final String? id,
      required final String title,
      required final String externalId,
      final List<String>? authors,
      final int? publicationYear,
      final int? isbn,
      final String? coverImageSmall,
      final String? coverImageLarge}) = _$_Book;

  @override
  String? get id;
  @override
  String get title;
  @override
  String get externalId;
  @override
  List<String>? get authors;
  @override
  int? get publicationYear;
  @override
  int? get isbn;
  @override
  String? get coverImageSmall;
  @override
  String? get coverImageLarge;
  @override
  @JsonKey(ignore: true)
  _$$_BookCopyWith<_$_Book> get copyWith => throw _privateConstructorUsedError;
}
