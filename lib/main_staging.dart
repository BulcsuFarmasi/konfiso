import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/firebase_options_prod.dart';
import 'package:konfiso/shared/widgets/app/view/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform, name: 'staging');

  runApp(const ProviderScope(child: App()));
}