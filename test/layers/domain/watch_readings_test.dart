import 'package:mibook/layers/domain/models/reading_domain.dart';
import 'package:mibook/layers/domain/repository/reading_repository.dart';
import 'package:mibook/layers/domain/usecases/watch_readings.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<IReadingRepository>()])
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'watch_readings_test.mocks.dart';

void main() {
  late MockIReadingRepository mockReadingRepository;
  late WatchReadings watchReadings;
  late Stream<List<ReadingDomain>> mockStream;

  setUp(() {
    mockReadingRepository = MockIReadingRepository();
    watchReadings = WatchReadings(mockReadingRepository);

    // Create mock ReadingDomain objects
    final reading1 = ReadingDomain(
      bookId: '1',
      bookName: 'Book 1',
      bookThumb: 'thumb1.jpg',
      progress: 0.5,
    );
    final reading2 = ReadingDomain(
      bookId: '2',
      bookName: 'Book 2',
      bookThumb: 'thumb2.jpg',
      progress: 0.8,
    );

    // Create a mock stream that emits lists of ReadingDomain
    mockStream = Stream.fromIterable([
      [reading1],
      [reading1, reading2],
    ]);

    // Stub the watchReadings method to return our mock stream
    when(mockReadingRepository.watchReadings()).thenAnswer((_) => mockStream);
  });

  group('WatchReadings - call', () {
    test('should return the stream from reading repository', () async {
      // Act
      final result = watchReadings.call();

      // Assert
      expect(result, equals(mockStream));
      verify(mockReadingRepository.watchReadings()).called(1);
      verifyNoMoreInteractions(mockReadingRepository);
    });

    test('should emit the same values as the repository stream', () async {
      // Arrange
      final emittedValues = <List<ReadingDomain>>[];

      // Act
      final subscription = watchReadings.call().listen(
        (data) => emittedValues.add(data),
      );

      // Wait for stream to complete
      await Future.delayed(Duration.zero);
      await subscription.cancel();

      // Assert
      expect(emittedValues.length, equals(2));
      expect(emittedValues[0].length, equals(1));
      expect(emittedValues[0][0].bookId, equals('1'));
      expect(emittedValues[1].length, equals(2));
      expect(emittedValues[1][0].bookId, equals('1'));
      expect(emittedValues[1][1].bookId, equals('2'));
      verify(mockReadingRepository.watchReadings()).called(1);
    });

    test('should handle errors from repository stream', () async {
      // Arrange
      final errorStream = Stream<List<ReadingDomain>>.error(
        Exception('Repository error'),
      );
      when(
        mockReadingRepository.watchReadings(),
      ).thenAnswer((_) => errorStream);

      // Act & Assert
      expect(
        () => watchReadings.call().first,
        throwsA(isA<Exception>()),
      );
      verify(mockReadingRepository.watchReadings()).called(1);
    });

    test('should handle empty stream from repository', () async {
      // Arrange
      final emptyStream = Stream<List<ReadingDomain>>.empty();
      when(
        mockReadingRepository.watchReadings(),
      ).thenAnswer((_) => emptyStream);

      // Act
      final emittedValues = <List<ReadingDomain>>[];
      final subscription = watchReadings.call().listen(
        (data) => emittedValues.add(data),
      );

      await Future.delayed(Duration.zero);
      await subscription.cancel();

      // Assert
      expect(emittedValues, isEmpty);
      verify(mockReadingRepository.watchReadings()).called(1);
    });
  });
}
