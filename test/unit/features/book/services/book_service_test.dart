import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/features/book/data/volume.dart';
import 'package:konfiso/features/book/services/book_remote.dart';
import 'package:konfiso/features/book/services/book_service.dart';
import 'package:konfiso/shared/exceptions/network_execption.dart';

import 'package:mocktail/mocktail.dart';

class MockBookRemote extends Mock implements BookRemote {}

void main() {
  group('BookService', () {
    late BookService bookService;
    late BookRemote bookRemote;
    late String externalId;
    late Volume volume;
    late String searchTerm;

    setUp(() {
      bookRemote = MockBookRemote();
      bookService = BookService(bookRemote);
      externalId = 'ab';
      searchTerm = 'harry potter';
      volume = Volume(
        externalId,
        const VolumeInfo(
          title: 'Harry Potter and the Chamber of Secrets',
          authors: ['JK Rowling'],
          publishedDate: '1998-01-11',
          imageLinks: ImageLinks(
            'https://upload.wikimedia.org/wikipedia/en/5/5c/Harry_Potter_and_the_Chamber_of_Secrets.jpg',
            'https://upload.wikimedia.org/wikipedia/en/5/5c/Harry_Potter_and_the_Chamber_of_Secrets.jpg',
          ),
          industryIdentifiers: [
            VolumeIndustryIdentifier('ISBN_13', '1234567891234'),
          ],
        ),
      );
    });

    void arrangeRemoteReturnsWithVolumeMap() {
      when(() => bookRemote.loadBookByExternalId(externalId)).thenAnswer((_) =>
          Future.value(Response<String>(
              requestOptions: RequestOptions(path: 'a'),
              data: jsonEncode(volume.toJson()))));
    }

    group('search', () {
      test(
          'should return with volumes if volumes are provided in response from book remote',
          () async {
        when(() => bookRemote.search(searchTerm)).thenAnswer(
          (_) => Future.value(
            Response<String>(
              requestOptions: RequestOptions(path: 'ab'),
              data: jsonEncode({
                'totalItems': 1,
                'items': [volume],
              }),
            ),
          ),
        );

        expectLater(await bookService.search(searchTerm), [volume]);
      });
      test(
          'should return with empty list if volumes are nor provided in response from book remote',
          () async {
        when(() => bookRemote.search(searchTerm)).thenAnswer(
          (_) => Future.value(
            Response<String>(
              requestOptions: RequestOptions(path: 'ab'),
              data: jsonEncode({
                'totalItems': 0,
              }),
            ),
          ),
        );

        expectLater(await bookService.search(searchTerm), []);
      });
      test('should throw an error if an error was throw by the book remote',
          () async {
        when(() => bookRemote.search(searchTerm)).thenThrow(
          DioError(
            requestOptions: RequestOptions(path: 'ab'),
          ),
        );

        expect(
          bookService.search(searchTerm),
          throwsA(
            predicate((e) => e is NetworkException),
          ),
        );
      });
    });
    group('loadByExternalId', () {
      test(
          'should return with volume which was converted from authRemote response',
          () async {
        // arrange remote return with response
        arrangeRemoteReturnsWithVolumeMap();
        // check if return value equals with volume
        expectLater(await bookService.loadBookByExternalId(externalId), volume);
      });
    });
  });
}
