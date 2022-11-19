import 'package:flutter_riverpod/flutter_riverpod.dart';

final timeUtilProvider = Provider((_) => TimeUtil());

class TimeUtil {
  DateTime now() => DateTime.now();
}
