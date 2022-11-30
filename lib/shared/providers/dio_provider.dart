import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/utils/flavor_util.dart';

final dioProvider = Provider((Ref ref) {
  final flavorUtil = ref.read(flavorUtilProvider);
  final dio = Dio();
  dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path.contains('googleapis')) {
      options.path = (options.path.contains('?'))
          ? '${options.path}&key=${flavorUtil.currentConfig.values.googleApiKey}'
          : '${options.path}?key=${flavorUtil.currentConfig.values.googleApiKey}';
      // options.path =
      //     ';
      handler.next(options);
    } else {
      handler.next(options);
    }
  }));
  return dio;
});
