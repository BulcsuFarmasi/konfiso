import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageServiceProvider = Provider((_) => LanguageService());

class LanguageService {
  late String locale;
}
