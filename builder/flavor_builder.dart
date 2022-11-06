import 'dart:async';
import 'dart:io';

import 'package:build/build.dart';

class FlavorBuilder extends Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) {
    final inputId = buildStep.inputId;
    print(Platform.environment['APP_ENV']);
  }

  @override
  Map<String, List<String>> get buildExtensions => const {'.build.dart': ['.dart']};
  
}