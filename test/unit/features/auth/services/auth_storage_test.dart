import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/data/stored_user.dart';
import 'package:konfiso/features/auth/services/auth_storage.dart';
import 'package:konfiso/shared/secure_storage.dart';
import 'package:konfiso/shared/storage_keys.dart';
import 'package:mocktail/mocktail.dart';

class MockSecureStorage extends Mock implements SecureStorage {}

void main() {
  group('AuthStorage', () {
    late SecureStorage secureStorage;
    late AuthStorage authStorage;
    late StoredUser user;

    setUp(() {
      secureStorage = MockSecureStorage();
      authStorage = AuthStorage(secureStorage);
      user = StoredUser(
        userId: '',
        token: '',
        refreshToken: '',
        validUntil: DateTime.now(),
      );
    });

    group('saveUser', () {
      test(
          'should call secure storage write method with transformed user object',
          () {
        when(() =>
                secureStorage.write(storedUserKey, jsonEncode(user.toJson())))
            .thenAnswer((invocation) => Future.value(null));

        authStorage.saveUser(user);

        verify(() =>
            secureStorage.write(storedUserKey, jsonEncode(user.toJson())));
      });
    });
    group('deleteUser', () {
      test('should secure storage delete method with approriate params', () {
        when(() => secureStorage.delete(storedUserKey))
            .thenAnswer((invocation) => Future.value(null));

        authStorage.deleteUser();

        verify(() => secureStorage.delete(storedUserKey));
      });
    });
    group('fetchUser', () {
      test('should return with storedUser if it is stored', () async {
        when(() => secureStorage.read(storedUserKey)).thenAnswer(
            (invocation) => Future.value(jsonEncode(user.toJson())));

        expectLater(await authStorage.fetchUser(), user);
      });
      test('should return with null if no user is stored', () async {
        when(() => secureStorage.read(storedUserKey))
            .thenAnswer((invocation) => Future.value(null));

        expectLater(await authStorage.fetchUser(), isNull);
      });
    });
  });
}
