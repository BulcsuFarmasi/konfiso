import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/data/stored_user.dart';
import 'package:konfiso/shared/secure_storage.dart';
import 'package:konfiso/shared/storage_keys.dart';

final authStorageProvider =
    Provider((Ref ref) => AuthStorage(ref.read(secureStorageProvider)));

class AuthStorage {
  final SecureStorage _secureStorage;

  AuthStorage(this._secureStorage);

  void saveUser(StoredUser user) {
    _secureStorage.write(storedUserKey, json.encode(user.toJson()));
  }

  void deleteUser() {
    _secureStorage.delete(storedUserKey);
  }

  Future<StoredUser?> fetchUser() async {
    final storedUser = await _secureStorage.read(storedUserKey);
    if (storedUser != null) {
      return StoredUser.fromJson(jsonDecode(storedUser));
    } else {
      return null;
    }
  }
}
