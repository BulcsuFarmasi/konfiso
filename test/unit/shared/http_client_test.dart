@TestOn('vm')
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/shared/http_client.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('HttpClient', () {
    late HttpClient httpClient;
    late Dio dio;
    late Response response;
    late String path;

    void arrangeDioGetReturnsWithResponse() {
      when(() => dio.get(path)).thenAnswer((_) => Future.value(response));
    }

    void arrangeDioPatchReturnsWithResponse() {
      when(() => dio.patch(path)).thenAnswer((_) => Future.value(response));
    }

    void arrangeDioPostReturnsWithResponse() {
      when(() => dio.post(path)).thenAnswer((_) => Future.value(response));
    }

    setUp(() {
      dio = MockDio();
      httpClient = HttpClient(dio);
      path = 'https://test.com';
      response = Response(requestOptions: RequestOptions(path: path));
    });

    group('get', () {
      test('should return with the provided response', () async {
        arrangeDioGetReturnsWithResponse();
        expectLater(await httpClient.get(url: path), response);
      });
    });

    group('patch', () {
      test('should return with the provided response', () async {
        arrangeDioPatchReturnsWithResponse();
        expectLater(await httpClient.patch(url: path), response);
      });
    });

    group('post', () {
      test('should return with the provided response', () async {
        arrangeDioPostReturnsWithResponse();
        expectLater(await httpClient.post(url: path), response);
      });
    });
  });
}
