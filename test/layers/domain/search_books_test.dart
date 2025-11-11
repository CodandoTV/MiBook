import 'package:flutter_test/flutter_test.dart';
import 'package:mibook/layers/domain/repository/search_repository.dart';
import 'package:mibook/layers/domain/usecases/search_books.dart';
import 'package:mibook/layers/domain/usecases/start_reading.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fakes/fake_book_list_domain.dart';
import 'search_books_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ISearchRepository>(), MockSpec<IStartReading>()])
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
          initTitle: anyNamed('initTitle'),
          startIndex: anyNamed('startIndex'),
        ),
      ).thenAnswer((_) async => Future.value(fakeBookListDomain));

      final result = await searchBooks.call(
        initTitle: 'initTitle',
        startIndex: 0,
      );
      verify(
        mockSearchRepository.searchByTitle(
          initTitle: anyNamed('initTitle'),
          startIndex: anyNamed('startIndex'),
        ),
      ).called(1);

      expect(result, fakeBookListDomain);
    });

    test(
      'call throws Exception with correct message when repository fails',
      () async {
        when(
          mockSearchRepository.searchByTitle(
            initTitle: 'initTitle',
            startIndex: 0,
          ),
        ).thenThrow(Exception('Something went wrong'));

        expect(
          () => searchBooks.call(
            initTitle: 'initTitle',
            startIndex: 0,
          ),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Something went wrong'),
            ),
          ),
        );
      },
    );
  });
}
