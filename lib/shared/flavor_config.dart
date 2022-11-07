enum Flavor {dev, staging, prod}

class FlavorValues {
  final String firebaseApiKey;

  FlavorValues(this.firebaseApiKey);
}

class FlavorConfig {
  final Flavor flavor;
  final FlavorValues values;

  FlavorConfig(this.flavor, this.values);

  bool isDev() => flavor == Flavor.dev;
  bool isStaging() => flavor == Flavor.staging;
  bool isProd() => flavor == Flavor.prod;
}