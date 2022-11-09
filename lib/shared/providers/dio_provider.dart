import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/services/flavor_service.dart';

final dioProvider = Provider((Ref ref) {
  final flavorService = ref.read(flavorServiceProvider);
  final dio = Dio();
  dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path.contains('googleapis')) {
      options.path = '${options.path}?key=${flavorService.currentConfig.values.firebaseApiKey}';
      handler.next(options);
    } else {
      handler.next(options);
    }
  }));
  return dio;
});

