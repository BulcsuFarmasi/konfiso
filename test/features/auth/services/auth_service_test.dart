import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:konfiso/features/auth/services/refresh_token_request_payload.dart';
import 'package:konfiso/features/auth/services/stored_user.dart';
import 'package:konfiso/shared/http_client.dart';
import 'package:konfiso/shared/secret.dart';
import 'package:konfiso/shared/secure_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<SecureStorage>(),
  MockSpec<HttpClient>(),
])
import 'auth_service_test.mocks.dart';

void main() {
  group('AuthService', () {
    late HttpClient httpClient;
    late SecureStorage secureStorage;
    late AuthService authService;
    late String email;
    late String password;
    setUp(() {
      httpClient = MockHttpClient();
      secureStorage = MockSecureStorage();
      authService = AuthService(httpClient, secureStorage);
      email = 'test@test.com';
      password = '123456';
    });

    group('autoSignIn', skip: 'TODO auth service later', () {
      test('should return with true is user is defined', () async {
        authService.user = StoredUser(
            userId: '',
            token: '',
            refreshToken: '',
            validUntil: DateTime.now());
        const url =
            'https://securetoken.googleapis.com/v1/token?key=$firebaseApiKey';
        when(httpClient.post(
                url: url,
                data:
                    RefreshTokenRequestPayload(authService.user!.refreshToken)))
            .thenAnswer(
          (realInvocation) {
            print(realInvocation.namedArguments);
            return Future.value(
            Response(requestOptions: RequestOptions(path: url), data: {
              'user_id': '',
              'id_token': '',
              'refresh_token': '',
              'expires_in': '3600'
            }),
          );}
        );
        print(await authService.autoSignIn());
        logInvocations([httpClient as MockHttpClient]);
        // expectLater(authService.autoSignIn(), Future.value(true));
      });
    });
  });
}
