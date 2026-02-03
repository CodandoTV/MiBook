import 'package:mibook/layers/domain/models/book_list_domain.dart';
import 'package:mibook/layers/domain/repository/favorite_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<IFavoriteRepository>()])
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'watch_favorite_test.mocks.dart';

void main() {
  late MockIFavoriteRepository mockFavoriteRepository;
  late Stream<List<BookDomain>> mockStream;

  setUp(() {
    mockFavoriteRepository = MockIFavoriteRepository();

    // Create mock BookDomain objects
    final book1 = BookDomain(
      id: '1',
      kind: 'Fiction',
      title: 'The Great Adventure',
    );
    final book2 = BookDomain(
      id: '2',
      kind: 'Mystery',
      title: 'The Hidden Secret',
    );

    // Create a mock stream that emits lists of BookDomain
    mockStream = Stream.fromIterable([
      [book1],
      [book1, book2],
    ]);

    // Stub the watchFavoriteBooks method to return our mock stream
    when(
      mockFavoriteRepository.watchFavoriteBooks(),
    ).thenAnswer((_) => mockStream);
  });

  group('WatchFavoriteBooks - call', () {
    test('should return the stream from favorite repository', () async {
      // Act
      final result = mockFavoriteRepository.watchFavoriteBooks();

      // Assert
      expect(result, equals(mockStream));
      verify(mockFavoriteRepository.watchFavoriteBooks()).called(1);
      verifyNoMoreInteractions(mockFavoriteRepository);
    });

    test('should emit the same values as the repository stream', () async {
      // Arrange
      final emittedValues = <List<BookDomain>>[];

      // Act
      final subscription = mockFavoriteRepository.watchFavoriteBooks().listen(
        emittedValues.add,
      );

      // Await for the stream to complete
      await subscription.asFuture();
      await subscription.cancel();

      // Assert
      expect(emittedValues.length, 2);
      expect(emittedValues[0], [
        BookDomain(id: '1', kind: 'Fiction', title: 'The Great Adventure'),
      ]);
      expect(emittedValues[1], [
        BookDomain(id: '1', kind: 'Fiction', title: 'The Great Adventure'),
        BookDomain(id: '2', kind: 'Mystery', title: 'The Hidden Secret'),
      ]);
    });
  });
}
