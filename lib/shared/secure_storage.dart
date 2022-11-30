import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:konfiso/shared/providers/flutter_secure_storage_provider.dart';

final secureStorageProvider = Provider((Ref ref) => SecureStorage(ref.read(flutterSecureStorageProvider)));

class SecureStorage {
  final FlutterSecureStorage _flutterSecureStorage;

  SecureStorage(this._flutterSecureStorage);

  Future<void> write(String key, String value) {
    return _flutterSecureStorage.write(key: key, value: value);
  }

  Future<String?> read(String key) {
    return _flutterSecureStorage.read(key: key);
  }

  Future<void> delete(String key) {
    return _flutterSecureStorage.delete(key: key);
  }
}
