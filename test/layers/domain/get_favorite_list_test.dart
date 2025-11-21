import 'package:flutter_test/flutter_test.dart';
import 'package:mibook/layers/domain/usecases/get_favorite_list.dart';
import 'package:mockito/mockito.dart';

import '../data/repository/fake_book_domain.dart';
import 'set_favorite_test.mocks.dart';

void main() {
  late MockIFavoriteRepository mockFavoriteRepository;
  late GetFavoriteList sut;

  setUp() {
    mockFavoriteRepository = MockIFavoriteRepository();
    sut = GetFavoriteList(mockFavoriteRepository);
  }

  group('test GetFavoriteList', () {
    setUp();

    test('call', () async {
      when(
        mockFavoriteRepository.getFavoriteBooks(),
      ).thenAnswer((_) async => [fakeBookDomain]);
      final result = await sut();
      verify(mockFavoriteRepository.getFavoriteBooks()).called(1);
      expect(result, [fakeBookDomain]);
    });
  });
}
