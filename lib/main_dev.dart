import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:konfiso/firebase_options.dart';
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
  Hive.init(applicationDocumentsDirectory.path);
}
