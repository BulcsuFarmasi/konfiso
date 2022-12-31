import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
class Env {
  @EnviedField(varName: 'DEV_GOOGLE_API_KEY', obfuscate: true)
  static final devGoogleApiKey = _Env.devGoogleApiKey;

  @EnviedField(varName: 'DEV_FIREBASE_DB_URL', obfuscate: true)
  static final devFirebaseDBUrl = _Env.devFirebaseDBUrl;

  @EnviedField(varName: 'PROD_GOOGLE_API_KEY', obfuscate: true)
  static final prodGoogleApiKey = _Env.prodGoogleApiKey;

  @EnviedField(varName: 'PROD_FIREBASE_DB_URL', obfuscate: true)
  static final prodFirebaseDBUrl = _Env.prodFirebaseDBUrl;

  @EnviedField(varName: 'MOLY_API_KEY', obfuscate: true)
  static final molyApiKey = _Env.molyApiKey;
}
