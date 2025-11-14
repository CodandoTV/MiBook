import 'package:flutter_test/flutter_test.dart';
import 'package:mibook/layers/data/datasource/favorite_data_source.dart';
import 'package:mibook/layers/data/repository/favorite_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../datasource/fake_book_item.dart';
import 'fake_book_domain.dart';
@GenerateNiceMocks([MockSpec<IFavoriteDataSource>()])
import 'favorite_repository_test.mocks.dart';

void main() {
  late MockIFavoriteDataSource mockFavoriteDataSource;
  late FavoriteRepository sut;

  setUp() {
    mockFavoriteDataSource = MockIFavoriteDataSource();
    sut = FavoriteRepository(mockFavoriteDataSource);
  }

  group('FavoriteDataSource', () {
    setUp();

    test('getFavoriteBooks', () async {
      when(
        mockFavoriteDataSource.getFavoriteBooks(),
      ).thenAnswer((_) async => [fakeBookItem]);
      final result = await sut.getFavoriteBooks();
      verify(mockFavoriteDataSource.getFavoriteBooks()).called(1);
      expect(result, [fakeBookDomain]);
    });

    test('getFavoriteStatus', () async {
      when(
        mockFavoriteDataSource.getFavoriteStatus('id'),
      ).thenAnswer((_) async => true);
      final result = await sut.getFavoriteStatus('id');
      verify(mockFavoriteDataSource.getFavoriteStatus('id')).called(1);
      expect(result, true);
    });

    test('setFavoriteStatus', () async {
      await sut.setFavoriteStatus(fakeBookDomain, true);
      verify(
        mockFavoriteDataSource.setFavoriteStatus(
          any,
          true,
        ),
      ).called(1);
    });
  });
}
