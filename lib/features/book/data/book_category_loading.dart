import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/book/data/book.dart';

part 'book_category_loading.freezed.dart';

@freezed
class BookCategoryLoading with _$BookCategoryLoading {
  const factory BookCategoryLoading({ required List<Book> books, required int currentBookNumber, required int totalBookNumber}) = _BookCategoryLoading;
}
