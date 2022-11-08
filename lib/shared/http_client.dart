import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/providers/dio_provider.dart';

final httpClientProvider = Provider((Ref ref) => HttpClient(ref.read(dioProvider)));

class HttpClient {
  final Dio _dio;

  HttpClient(this._dio);

  Future<Response> post({required String url, dynamic data}) {
    return _dio.post(url, data: data);
  }

  Future<Response> put({required String url, dynamic data}) {
    return _dio.put(url, data: data);
  }
}