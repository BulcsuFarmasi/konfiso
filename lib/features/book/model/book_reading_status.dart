import 'package:intl/intl.dart';

enum BookReadingStatus {
  currentlyReading,
  wantToRead,
  alreadyRead;
}

String currentlyReadingMessage() => Intl.message('Currently Reading');

String wantToReadMessage() => Intl.message('Want to Read');

String alreadyReadMessage() => Intl.message('Already Read');

String getReadingStatusDisplayText(BookReadingStatus readingStatus) {
  switch (readingStatus) {
    case BookReadingStatus.currentlyReading:
      return currentlyReadingMessage();
    case BookReadingStatus.wantToRead:
      return wantToReadMessage();
    case BookReadingStatus.alreadyRead:
      return alreadyReadMessage();
  }
}
