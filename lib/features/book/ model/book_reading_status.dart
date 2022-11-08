import 'package:intl/intl.dart';

enum BookReadingStatus {
  reading('Reading'),
  wantToRead('Want To Read'),
  alreadyRead('Already Read');


  final String displayText;

  const BookReadingStatus(this.displayText);

  @override
  String toString() => Intl.message(displayText);
}