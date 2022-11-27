import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/book/services/book_remote.dart';
import 'package:konfiso/shared/http_client.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late BookRemote bookRemote;
  late HttpClient httpClient;
  late String searchUrl;
  late Map<String, String> responseData;
  late String externalId;
  late String loadUrl;

  group('BookRemote', () {
    setUp(() {
      httpClient = MockHttpClient();
      bookRemote = BookRemote(httpClient);
      searchUrl =
          '${BookRemote.apiUrl}?q="harry+potter"&maxResults=10&startIndex=0';
      externalId = 'ab';
      responseData = {'id': externalId};
      loadUrl = '${BookRemote.apiUrl}/$externalId';
    });

    void arrangeHttpClientReturnsWithResponseForSearch(String url) {
      when(() => httpClient.get(url: url)).thenAnswer((_) => Future.value(
          Response<Map<String, String>>(
              requestOptions: RequestOptions(path: url), data: responseData)));
    }

    group('search', () {
      test('should call http client get with constructed url', () {
        arrangeHttpClientReturnsWithResponseForSearch(searchUrl);

        bookRemote.search('harry potter');

        verify(() => httpClient.get(url: searchUrl));
      });
      test('should return with resposne got from http client', () async {
        arrangeHttpClientReturnsWithResponseForSearch(searchUrl);

        expectLater(
          (await bookRemote.search('harry potter')).data,
          responseData,
        );
      });
    });
    group('loadBookByExternalId', () {
      test('should call http client get with constructed url', () {
        arrangeHttpClientReturnsWithResponseForSearch(loadUrl);

        bookRemote.loadBookByExternalId(externalId);

        verify(() => httpClient.get(url: loadUrl));
      });
      test('should return with response got from http client', () async {
        arrangeHttpClientReturnsWithResponseForSearch(loadUrl);

        expectLater(
          (await bookRemote.loadBookByExternalId(externalId)).data,
          responseData,
        );
      });
    });
  });
}
