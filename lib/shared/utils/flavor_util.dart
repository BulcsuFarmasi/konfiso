import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/flavor.dart';
import 'package:konfiso/shared/flavor_config.dart';
import 'package:konfiso/shared/secret.dart';

final flavorUtilProvider = Provider((_) => FlavorUtil());

class FlavorUtil {
  FlavorConfig get currentConfig {
    switch (flavor) {
      case Flavor.dev:
        return FlavorConfig(
            Flavor.dev, FlavorValues(devGoogleApiKey, devFirebaseDBUrl));
      case Flavor.staging:
        return FlavorConfig(Flavor.staging,
            FlavorValues(prodGoogleApiKey, prodFirebaseDBUrl));
      case Flavor.prod:
        return FlavorConfig(
            Flavor.prod, FlavorValues(prodGoogleApiKey, prodFirebaseDBUrl));
    }
  }
}
