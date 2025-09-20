import 'package:flutter_test/flutter_test.dart';
import 'package:mibook/layers/domain/repository/search_repository.dart';
import 'package:mibook/layers/domain/usecases/search_books.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fakes/fake_book_list_domain.dart';

@GenerateNiceMocks([MockSpec<ISearchRepository>()])
import 'search_books_test.mocks.dart';

void main() {
  late MockISearchRepository mockSearchRepository;
  late SearchBooks searchBooks;

  setUp(() {
    mockSearchRepository = MockISearchRepository();
    searchBooks = SearchBooks(
      mockSearchRepository,
    );
  });

  group('SearchBooks', () {
    test('call returns BookListDomain on success', () async {
      when(
        mockSearchRepository.searchByTitle(
          initTitle: 'initTitle',
          startIndex: 0,
        ),
      ).thenAnswer((_) async => Future.value(fakeBookListDomain));

      final result = await searchBooks.call(
        initTitle: 'initTitle',
        startIndex: 0,
      );
      expect(result, fakeBookListDomain);
    });

    test('call returns BookListDomain on failure', () async {
      when(
        mockSearchRepository.searchByTitle(
          initTitle: 'initTitle',
          startIndex: 0,
        ),
      ).thenThrow(Exception('Something went wrong'));

      var error = false;
      try {
        await searchBooks.call(
          initTitle: 'initTitle',
          startIndex: 0,
        );
        error = false;
      } catch (e) {
        error = true;
      }

      expect(error, isTrue);
    });
  });
}
