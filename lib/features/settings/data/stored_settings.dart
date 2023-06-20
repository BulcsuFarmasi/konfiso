import 'package:hive/hive.dart';

part 'stored_settings.g.dart';

@HiveType(typeId: 8)
class StoredSettings {
  StoredSettings(this.darkMode);

  @HiveField(0)
  final bool darkMode;
}
