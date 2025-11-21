import 'package:flutter_test/flutter_test.dart';
import 'package:mibook/layers/domain/repository/favorite_repository.dart';
import 'package:mibook/layers/domain/usecases/get_favorite.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<IFavoriteRepository>()])
import 'set_favorite_test.mocks.dart';

void main() {
  late MockIFavoriteRepository mockFavoriteRepository;
  late GetFavorite sut;

  setUp() {
    mockFavoriteRepository = MockIFavoriteRepository();
    sut = GetFavorite(mockFavoriteRepository);
  }

  group('test GetFavorite', () {
    setUp();

    test('call', () async {
      when(
        mockFavoriteRepository.getFavoriteStatus('id'),
      ).thenAnswer((_) async => true);
      final result = await sut('id');
      verify(mockFavoriteRepository.getFavoriteStatus('id')).called(1);
      expect(result, true);
    });
  });
}
