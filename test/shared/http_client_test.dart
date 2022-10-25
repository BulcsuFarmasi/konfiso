@TestOn('vm')

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/shared/http_client.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<Dio>()])
import 'http_client_test.mocks.dart';

void main() {
  group('HttpClient', () {
    late HttpClient httpClient;
    late Dio dio;
    late Response response;
    late String path;

    setUp(() {
      dio = MockDio();
      httpClient = HttpClient(dio);
      path = 'https://test.com';
      response = Response(requestOptions: RequestOptions(path: path));
    });

    group('post', ()  {
      test('should return with the provided response', () async {

      when(dio.post(path)).thenAnswer((_) => Future.value(response));
      expectLater(await httpClient.post(url: path), response);
      });
    });
  });
}