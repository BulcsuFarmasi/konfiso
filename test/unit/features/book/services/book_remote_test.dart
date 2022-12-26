import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/book/services/book_google_remote.dart';
import 'package:konfiso/shared/http_client.dart';
import 'package:konfiso/shared/utils/flavor_util.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockFlavorUtil extends Mock implements FlavorUtil {}

void main() {
  late BookGoogleRemote bookRemote;
  late HttpClient httpClient;
  late FlavorUtil flavorUtil;
  late String searchUrl;
  late Map<String, String> responseData;
  late String isbn;
  late String loadUrl;

  group('BookRemote', () {
    setUp(() {
      httpClient = MockHttpClient();
      flavorUtil = FlavorUtil();
      bookRemote = BookGoogleRemote(httpClient, flavorUtil);
      searchUrl = '${BookGoogleRemote.apiUrl}?q="harry+potter"&maxResults=10&startIndex=0';
      isbn = 'isbn';
      responseData = {'id': isbn};
      loadUrl = '${BookGoogleRemote.apiUrl}/?q=isbn:$isbn';
    });

    void arrangeHttpClientReturnsWithResponseForSearch(String url) {
      when(() => httpClient.get(url: url)).thenAnswer((_) =>
          Future.value(Response<Map<String, String>>(requestOptions: RequestOptions(path: url), data: responseData)));
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

        bookRemote.loadBookByIsbn(isbn);

        verify(() => httpClient.get(url: loadUrl));
      });
      test('should return with response got from http client', () async {
        arrangeHttpClientReturnsWithResponseForSearch(loadUrl);

        expectLater(
          (await bookRemote.loadBookByIsbn(isbn)).data,
          responseData,
        );
      });
    });
  });
}
