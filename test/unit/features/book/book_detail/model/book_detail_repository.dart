import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/book/book_detail/model/book_detail_repository.dart';
import 'package:konfiso/features/book/model/book.dart';
import 'package:konfiso/features/book/model/industry_identifier.dart';
import 'package:konfiso/features/book/model/volume.dart';
import 'package:konfiso/features/book/services/book_service.dart';
import 'package:mocktail/mocktail.dart';

class MockBookService extends Mock implements BookService {}

void main() {
  late BookDetailRepository bookDetailRepository;
  late BookService bookService;
  late Book book;
  late Volume volume;
  late String externalId;

  setUp(() {
    bookService = MockBookService();
    bookDetailRepository = BookDetailRepository(bookService);
    externalId = 'ab';
    book = Book(
      title: 'Harry Potter and the Chamber of Secrets',
      externalId: externalId,
      authors: ['JK Rowling'],
      publicationYear: '1998',
      coverImageLarge:
          'https://upload.wikimedia.org/wikipedia/en/5/5c/Harry_Potter_and_the_Chamber_of_Secrets.jpg',
      industryIds: [
        const BookIndustryIdentifier(
            IndustryIdentifierType.isbn13, '1234567891234'),
      ],
    );
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

  void arrangeServiceReturnsWithBook() {
    when(() => bookService.loadBookByExternalId(externalId))
        .thenAnswer((_) => Future.value(volume));
  }

  group('BookDetailRepository', () {
    group('loadBookByExternalId', () {
      test(
          'should return the book instance converted from volume which got from service',
          () async {
        arrangeServiceReturnsWithBook();

        expectLater(
            await bookDetailRepository.loadBookByExternalId(externalId), book);
      });
    });
  });
}
