import 'package:flutter_riverpod/flutter_riverpod.dart';

final timeServiceProvider = Provider((_) => TimeService());

class TimeService {
  DateTime now() => DateTime.now();
}
