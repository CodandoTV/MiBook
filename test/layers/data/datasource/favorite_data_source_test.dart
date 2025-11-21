import 'package:flutter_test/flutter_test.dart';
import 'package:mibook/layers/data/api/storage_client.dart';
import 'package:mibook/layers/data/datasource/favorite_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fake_book_item.dart';
@GenerateNiceMocks([MockSpec<IStorageClient>()])
import 'favorite_data_source_test.mocks.dart';

void main() {
  late MockIStorageClient storageClient;
  late FavoriteDataSource sut;

  setUp() {
    storageClient = MockIStorageClient();
    sut = FavoriteDataSource(storageClient);
  }

  group('FavoriteDataSource', () {
    setUp();

    test('setFavoriteStatus', () async {
      await sut.setFavoriteStatus(fakeBookItem, true);
      verify(storageClient.setFavoriteStatus(fakeBookItem, true)).called(1);
    });

    test('getFavoriteStatus', () async {
      when(storageClient.getFavoriteStatus('id')).thenAnswer((_) async => true);
      final result = await sut.getFavoriteStatus('id');
      verify(storageClient.getFavoriteStatus('id')).called(1);
      expect(result, true);
    });

    test('getFavoriteBooks', () async {
      final fakeBooks = [fakeBookItem];
      when(storageClient.getFavoriteBooks()).thenAnswer((_) async => fakeBooks);
      final result = await sut.getFavoriteBooks();
      verify(storageClient.getFavoriteBooks()).called(1);
      expect(result, fakeBooks);
    });
  });
}
