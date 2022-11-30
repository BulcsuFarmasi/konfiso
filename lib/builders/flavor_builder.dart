import 'dart:async';
import 'dart:io';

import 'package:build/build.dart';

Builder buildFlavor(BuilderOptions builderOptions) => _FlavorBuilder();

class _FlavorBuilder extends Builder {
  final output = 'lib/shared/flavor.dart';

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final appEnv = Platform.environment['APP_ENV'];

    await buildStep.writeAsString(buildStep.allowedOutputs.single, '''
import 'package:konfiso/shared/flavor_config.dart';
    
const flavor = Flavor.$appEnv; 
    ''');
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        'pubspec.yaml': [output]
      };
}
