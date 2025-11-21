import 'package:flutter_test/flutter_test.dart';
import 'package:mibook/layers/domain/repository/favorite_repository.dart';
import 'package:mibook/layers/domain/usecases/set_favorite.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../data/repository/fake_book_domain.dart';
@GenerateNiceMocks([MockSpec<IFavoriteRepository>()])
import 'set_favorite_test.mocks.dart';

void main() {
  late MockIFavoriteRepository mockFavoriteRepository;
  late SetFavorite sut;

  setUp() {
    mockFavoriteRepository = MockIFavoriteRepository();
    sut = SetFavorite(mockFavoriteRepository);
  }

  group('test SetFavorite', () {
    setUp();

    test('call', () async {
      await sut(fakeBookDomain, true);
      verify(
        mockFavoriteRepository.setFavoriteStatus(
          fakeBookDomain,
          true,
        ),
      ).called(1);
    });
  });
}
