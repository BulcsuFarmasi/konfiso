import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:konfiso/firebase_options_dev.dart';
import 'package:konfiso/shared/widgets/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}
