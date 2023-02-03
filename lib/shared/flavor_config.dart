enum Flavor { dev, staging, prod }

class FlavorValues {
  final String googleApiKey;
  final String firebaseDBUrl;

  FlavorValues(this.googleApiKey, this.firebaseDBUrl);
}

class FlavorConfig {
  final Flavor flavor;
  final FlavorValues values;

  FlavorConfig(this.flavor, this.values);

  bool isDev() => flavor == Flavor.dev;

  bool isProd() => flavor == Flavor.prod;
}
