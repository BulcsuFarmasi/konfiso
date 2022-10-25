@TestOn('vm')
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/shared/secure_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';


@GenerateNiceMocks([MockSpec<FlutterSecureStorage>()])
import 'secure_storage_test.mocks.dart';

void main() {
  group('SecureStorage', () {
    late SecureStorage secureStorage;
    late FlutterSecureStorage flutterSecureStorage;
    late String key;
    late String value;

    setUp(()  {
      flutterSecureStorage = MockFlutterSecureStorage();
      secureStorage = SecureStorage(flutterSecureStorage);
      key = 'key';
      value = 'value';
    });

    group('write', () {
      test('should call flutter secure storage\'s write method', () {
        secureStorage.write(key, value);
        verify(flutterSecureStorage.write(key: key, value: value));
      });
    });
    group('read', () {
      test('should call give back the value which flutter secure storage gave it to it', () async {
        when(flutterSecureStorage.read(key: key)).thenAnswer((_) => Future.value(value));
        expectLater(await secureStorage.read(key), value);
      });
    });
    group('delete', () {
      test('should call flutter secure storage\'s delete method', () {
        secureStorage.delete(key);
        verify(flutterSecureStorage.delete(key: key));
      });
    });
  });
}

