import 'package:konfiso/features/book/model/book_reading_status.dart';

class BookReadingDetail {
  final BookReadingStatus status;
  final double? rating;
  final String? comment;

  BookReadingDetail({required this.status, this.rating, this.comment});
}
