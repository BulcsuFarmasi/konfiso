import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/env/env.dart';
import 'package:konfiso/shared/flavor.dart';
import 'package:konfiso/shared/flavor_config.dart';

final flavorUtilProvider = Provider((_) => FlavorUtil());

class FlavorUtil {
  FlavorConfig get currentConfig {
    switch (flavor) {
      case Flavor.dev:
        return FlavorConfig(Flavor.dev, FlavorValues(Env.devGoogleApiKey, Env.devFirebaseDBUrl));
      case Flavor.staging:
        return FlavorConfig(Flavor.staging, FlavorValues(Env.prodGoogleApiKey, Env.prodFirebaseDBUrl));
      case Flavor.prod:
        return FlavorConfig(Flavor.prod, FlavorValues(Env.prodGoogleApiKey, Env.prodFirebaseDBUrl));
    }
  }
}
