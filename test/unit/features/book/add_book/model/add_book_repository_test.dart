import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/book/add_book/model/add_book_resopsitory.dart';
import 'package:konfiso/features/book/data/add_book_exception.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/features/book/data/volume.dart';
import 'package:konfiso/features/book/services/book_service.dart';
import 'package:konfiso/shared/exceptions/network_execption.dart';
import 'package:mocktail/mocktail.dart';

class MockBookService extends Mock implements BookService {}

void main() {
  late AddBookRepository addBookRepository;
  late BookService bookService;
  late List<Volume> volumes;
  late List<Book> books;

  setUp(() {
    bookService = MockBookService();
    addBookRepository = AddBookRepository(bookService);
    volumes = [
      const Volume(
        'ab',
        VolumeInfo(
          title: 'Harry Potter and the Chamber of Secrets',
          authors: ['JK Rowling'],
          publishedDate: '1999',
          imageLinks: ImageLinks(
            'https://upload.wikimedia.org/wikipedia/en/5/5c/Harry_Potter_and_the_Chamber_of_Secrets.jpg',
            'https://upload.wikimedia.org/wikipedia/en/5/5c/Harry_Potter_and_the_Chamber_of_Secrets.jpg',
          ),
          industryIdentifiers: [
            VolumeIndustryIdentifier('ISBN_13', '1234567891234'),
          ],
        ),
      ),
      const Volume(
        'cd',
        VolumeInfo(
          title: 'Harry Potter and the Prisoner of Azkaban',
          authors: ['JK Rowling'],
          publishedDate: '2000',
          imageLinks: ImageLinks(
            'https://upload.wikimedia.org/wikipedia/en/a/a0/Harry_Potter_and_the_Prisoner_of_Azkaban.jpg',
            'https://upload.wikimedia.org/wikipedia/en/a/a0/Harry_Potter_and_the_Prisoner_of_Azkaban.jpg',
          ),
          industryIdentifiers: [
            VolumeIndustryIdentifier('ISBN_13', '9876543212345'),
          ],
        ),
      ),
    ];
    books = [
      const Book(
        title: 'Harry Potter and the Chamber of Secrets',
        authors: ['JK Rowling'],
        coverImageSmall: 'https://upload.wikimedia.org/wikipedia/en/5/5c/Harry_Potter_and_the_Chamber_of_Secrets.jpg',
        industryIds: [BookIndustryIdentifier(IndustryIdentifierType.isbn13, '1234567891234')],
      ),
      const Book(
        title: 'Harry Potter and the Prisoner of Azkaban',
        authors: ['JK Rowling'],
        coverImageSmall: 'https://upload.wikimedia.org/wikipedia/en/a/a0/Harry_Potter_and_the_Prisoner_of_Azkaban.jpg',
        industryIds: [BookIndustryIdentifier(IndustryIdentifierType.isbn13, '9876543212345')],
      ),
    ];
  });

  void arrangeServiceReturnsWithVolumes(String searchTerm) {
    when(() => bookService.search(searchTerm)).thenAnswer((_) => Future.value(volumes));
  }

  void arrangeServiceThrowsError(String searchTerm) {
    when(() => bookService.search(searchTerm)).thenThrow(NetworkException('a'));
  }

  group('AddBookRepository', () {
    group('search', () {
      test('should return with empty list if empty search term given', () async {
        expectLater(await addBookRepository.search(''), []);
      });
      test('should return with books converted from volumes got from service', () async {
        const searchTerm = 'apple';
        arrangeServiceReturnsWithVolumes(searchTerm);

        expectLater(await addBookRepository.search(searchTerm), books);
      });
      test('should return with error if service throws error', () async {
        // set search term
        const searchTerm = 'apple';
        //arrnge error throwing
        arrangeServiceThrowsError(searchTerm);
        // check if is throwed an error
        expect(addBookRepository.search(searchTerm), throwsA(predicate((e) => e is AddBookException)));
      });
    });
  });
}
