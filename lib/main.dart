import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:konfiso/firebase_options.dart';
import 'package:konfiso/shared/widgets/app.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}
