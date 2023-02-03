import 'package:hive/hive.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';
import 'package:konfiso/features/book/data/stored_book.dart';

part 'stored_book_reading_detail.g.dart';

@HiveType(typeId: 5)
class StoredBookReadingDetail {
  @HiveField(0)
  final StoredBook book;
  @HiveField(1)
  final BookReadingStatus status;
  @HiveField(2)
  final int? currentPage;
  @HiveField(3)
  final double? rating;
  @HiveField(4)
  final String? comment;

  StoredBookReadingDetail(this.book, this.status, this.currentPage, this.rating, this.comment);
}
