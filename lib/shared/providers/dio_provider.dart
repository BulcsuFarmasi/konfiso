import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/data/stored_user.dart';
import 'package:konfiso/features/auth/services/auth_storage.dart';
import 'package:konfiso/shared/env/env.dart';
import 'package:konfiso/shared/utils/flavor_util.dart';

final dioProvider = Provider((Ref ref) {
  final flavorUtil = ref.read(flavorUtilProvider);
  final authStorage = ref.read(authStorageProvider);
  StoredUser? user;

  final dio = Dio();
  dio.interceptors
      .add(InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
    user = await authStorage.fetchUser();
    if (options.path.contains('googleapis')) {
      options.path = addParameterToPath(options.path, 'key', flavorUtil.currentConfig.values.googleApiKey);
    } else if (options.path.contains('moly')) {
      options.path = addParameterToPath(options.path, 'key', Env.molyApiKey);
    } else if (options.path.contains('firebasedatabase')) {
      options.path = addParameterToPath(options.path, 'auth', user?.token);
    }
    handler.next(options);
  }));
  return dio;
});

String addParameterToPath(String path, String key, String? value) {
  return path.contains('?') ? '$path&$key=$value' : '$path?$key=$value';
}
