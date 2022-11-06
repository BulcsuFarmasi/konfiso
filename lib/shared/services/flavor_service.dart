import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/flavor.dart';
import 'package:konfiso/shared/flavor_config.dart';
import 'package:konfiso/shared/secret.dart';

final flavorServiceProvider = Provider((_) => FlavorService());

class FlavorService {
  FlavorConfig get currentConfig {
    switch (flavor) {
      case Flavor.dev:
        return FlavorConfig(Flavor.dev, FlavorValues(devFirebaseApiKey));
      case Flavor.staging:
        return FlavorConfig(Flavor.staging, FlavorValues(prodFirsebaseApiKey));
      case Flavor.prod:
        return FlavorConfig(Flavor.prod, FlavorValues(prodFirsebaseApiKey));
    }
  }
}
