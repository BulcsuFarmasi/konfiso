import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/features/book/data/stored_book.dart';
import 'package:konfiso/features/book/data/stored_book_reading_detail.dart';
import 'package:konfiso/features/book/data/stored_search_result.dart';
import 'package:konfiso/firebase_options_dev.dart';
import 'package:konfiso/shared/widgets/app/view/app.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeFirebase();

  initializeHive();

  runApp(const ProviderScope(child: App()));
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> initializeHive() async {
  final applicationDocumentsDirectory = await getApplicationDocumentsDirectory();

  Hive.registerAdapter(StoredBookAdapter());
  Hive.registerAdapter(StoredCoverImageAdapter());
  Hive.registerAdapter(BookIndustryIdentifierAdapter());
  Hive.registerAdapter(IndustryIdentifierTypeAdapter());
  Hive.registerAdapter(StoredBookReadingDetailAdapter());
  Hive.registerAdapter(BookReadingStatusAdapter());
  Hive.registerAdapter(StoredSearchResultAdapter());

  Hive.init(applicationDocumentsDirectory.path);
}
