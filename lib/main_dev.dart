import 'package:flutter/material.dart';
import 'package:konfiso/shared/flavor_config.dart';
import 'package:konfiso/shared/secret.dart';
import 'package:konfiso/shared/widgets/app.dart';

void main() {
  FlavorConfig(
    Flavor.dev,
    FlavorValues(devFirebaseApiKey),
  );
  runApp(const App());
}
