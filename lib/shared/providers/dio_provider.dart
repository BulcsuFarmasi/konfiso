import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/env/env.dart';
import 'package:konfiso/shared/utils/flavor_util.dart';

final dioProvider = Provider((Ref ref) {
  final flavorUtil = ref.read(flavorUtilProvider);
  final dio = Dio();
  dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path.contains('googleapis')) {
      options.path = (options.path.contains('?'))
          ? '${options.path}&key=${flavorUtil.currentConfig.values.googleApiKey}'
          : '${options.path}?key=${flavorUtil.currentConfig.values.googleApiKey}';

      handler.next(options);
    } else if (options.path.contains('moly')) {
      options.path = (options.path.contains('?'))
          ? '${options.path}&key=${Env.molyApiKey}'
          : '${options.path}?key=${Env.molyApiKey}';
    } else {
      handler.next(options);
    }
  }));
  return dio;
});
