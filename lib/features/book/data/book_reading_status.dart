import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum BookReadingStatus {
  currentlyReading,
  wantToRead,
  alreadyRead;

  @override
  String toString() {
    switch (this) {
      case BookReadingStatus.currentlyReading:
        return 'currentlyReading';
      case BookReadingStatus.wantToRead:
        return 'wantToRead';
      case BookReadingStatus.alreadyRead:
        return 'alreadyRead';
    }
  }
}

String getReadingStatusDisplayText(BookReadingStatus readingStatus, BuildContext context) {
  switch (readingStatus) {
    case BookReadingStatus.currentlyReading:
      return AppLocalizations.of(context)!.currentlyReading;
    case BookReadingStatus.wantToRead:
      return AppLocalizations.of(context)!.wantToRead;
    case BookReadingStatus.alreadyRead:
      return AppLocalizations.of(context)!.alreadyRead;
  }
}
