@TestOn('vm')
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/shared/exceptions/network_execption.dart';

void main() {
  group('NetworkException', () {
    late NetworkException networkException;
    late String message;
    setUp(() {
      message = 'exception';
      networkException = NetworkException(message);
    });

    group('toString', () {
      test('should give back the message', () {
        expect(networkException.toString(), message);
      });
    });
  });
}
