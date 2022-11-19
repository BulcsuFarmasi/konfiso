import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/features/book/data/volume.dart';
import 'package:konfiso/features/book/services/book_remote.dart';
import 'package:konfiso/features/book/services/book_service.dart';

import 'package:mocktail/mocktail.dart';

class MockBookRemote extends Mock implements BookRemote {}

void main() {
  group('BookService', skip: 'solve type error',() {
    late BookService bookService;
    late BookRemote bookRemote;
    late String externalId;
    late Volume volume;

    setUp(() {
      bookRemote = MockBookRemote();
      bookService = BookService(bookRemote);
      externalId = 'ab';
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

    void arrangeRemoteReturnsWitVolumeMap() {
      when(() => bookRemote.loadBookByExternalId(externalId)).thenAnswer((_) =>
          Future.value(Response(
              requestOptions: RequestOptions(path: 'a'),
              data: volume.toJson())));
    }

    group('search', () {});
    group('loadByExternalId', () {
      test(
          'should return with volume which was converted from authRemote response',
          () async {
        // arrange remote return with response
        arrangeRemoteReturnsWitVolumeMap();
        // check if return value equals with volume
        expectLater(await bookService.loadBookByExternalId(externalId), volume);
      });
    });
  });
}
