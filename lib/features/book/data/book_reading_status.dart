import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';

part 'book_reading_status.g.dart';

@HiveType(typeId: 6)
enum BookReadingStatus {
  @HiveField(0)
  wantToRead,
  @HiveField(1)
  currentlyReading,
  @HiveField(2)
  alreadyRead;

  @override
  String toString() {
    switch (this) {
      case BookReadingStatus.wantToRead:
        return 'wantToRead';
      case BookReadingStatus.currentlyReading:
        return 'currentlyReading';
      case BookReadingStatus.alreadyRead:
        return 'alreadyRead';
    }
  }
}

String getReadingStatusDisplayText(BookReadingStatus readingStatus, BuildContext context) {
  switch (readingStatus) {
    case BookReadingStatus.wantToRead:
      return AppLocalizations.of(context)!.wantToRead;
    case BookReadingStatus.currentlyReading:
      return AppLocalizations.of(context)!.currentlyReading;
    case BookReadingStatus.alreadyRead:
      return AppLocalizations.of(context)!.alreadyRead;
  }
}
