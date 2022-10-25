@TestOn('vm')
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/shared/app_validators.dart';

void main() {
  group('AppValidators', () {
    group('required', () {
      test('should return true if the input is null',() {
        expect(AppValidators.required(null), true);
      });
      test('should return true if the input is empty',() {
        expect(AppValidators.required(''), true);
      });
      test('should return false if the input is NOT empty',() {
        expect(AppValidators.required('konfiso'), false);
      });
    });
    group('email', () {
      test('should return true if the input is NOT an email address',() {
        expect(AppValidators.email('baba'), true);
      });
      test('should return false if the input is null',() {
        expect(AppValidators.email(null), false);
      });
      test('should return false if the input is an email address',() {
        expect(AppValidators.email('test@test.com'), false);
      });
    });
    group('minLength', () {
      test('should return true if the input is shorter then required',() {
        expect(AppValidators.minLength('baba', 5), true);
      });
      test('should return false if the input is null',() {
        expect(AppValidators.minLength(null, 1), false);
      });
      test('should return false if the input is longer then required',() {
        expect(AppValidators.minLength('babok', 5), false);
      });
    });
    group('passwordMatch', () {
      test('should return true if the two inputs are different',() {
        expect(AppValidators.passwordMatch('alfa', 'beta'), true);
      });
      test('should return false if the input is longer then required',() {
        expect(AppValidators.passwordMatch('alfa', 'alfa'), false);
      });
    });
  });
}