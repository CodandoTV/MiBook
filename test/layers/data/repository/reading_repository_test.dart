import 'package:flutter_test/flutter_test.dart';
import 'package:mibook/layers/data/datasource/reading_data_source.dart';
import 'package:mibook/layers/data/models/reading_data.dart';
import 'package:mibook/layers/data/repository/reading_repository.dart';
import 'package:mibook/layers/domain/models/reading_domain.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reading_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IReadingDataSource>()])
void main() {
  late MockIReadingDataSource mockIReadingDataSource;
  late ReadingRepository sut;
  late Stream<List<ReadingData>> mockStream;

  setUp() {
    mockIReadingDataSource = MockIReadingDataSource();
    sut = ReadingRepository(mockIReadingDataSource);

    // Create mock ReadingData objects
    final readingData1 = ReadingData('1', 'Book 1', 'thumb1.jpg', 0.5);
    final readingData2 = ReadingData('2', 'Book 2', 'thumb2.jpg', 0.8);

    // Create a mock stream that emits lists of ReadingData
    mockStream = Stream.fromIterable([
      [readingData1],
      [readingData1, readingData2],
    ]);

    // Stub the watchReadingData method to return our mock stream
    when(
      mockIReadingDataSource.watchReadingData(),
    ).thenAnswer((_) => mockStream);
  }

  group('test ReadingRepository', () {
    setUp();

    test('startReading', () async {
      final readingDomain = ReadingDomain(
        bookId: 'id1',
        bookName: 'Harry Potter',
        progress: 0.5,
      );
      final readingData = ReadingData(
        'id1',
        'Harry Potter',
        null,
        0.5,
      );

      await sut.startReading(reading: readingDomain);

      verify(
        mockIReadingDataSource.startReading(
          readingData: argThat(
            predicate<ReadingData>(
              (data) =>
                  data.bookId == readingData.bookId &&
                  data.progress == readingData.progress,
            ),
            named: 'readingData',
          ),
        ),
      ).called(1);
    });
  });

  test('getReadings', () async {
    final fakeData = [
      ReadingData('id1', 'Harry Potter', null, 0.5),
      ReadingData('id2', 'Deltora Quest', null, 0.5),
    ];

    when(
      mockIReadingDataSource.getReadingData(),
    ).thenAnswer((_) async => fakeData);

    final response = await sut.getReadings();

    verify(mockIReadingDataSource.getReadingData()).called(1);
    expect(response.length, 2);
  });

  group('ReadingRepository - watchReadings', () {
    test(
      'should return a stream that maps ReadingData to ReadingDomain',
      () async {
        // Act
        final result = sut.watchReadings();

        // Assert
        expect(result, isA<Stream<List<ReadingDomain>>>());
        verify(mockIReadingDataSource.watchReadingData()).called(1);
        verifyNoMoreInteractions(mockIReadingDataSource);
      },
    );

    test(
      'should emit mapped ReadingDomain objects from ReadingData stream',
      () async {
        // Arrange
        final emittedValues = <List<ReadingDomain>>[];

        // Act
        final subscription = sut.watchReadings().listen(
          (data) => emittedValues.add(data),
        );

        // Wait for stream to complete
        await Future.delayed(Duration.zero);
        await subscription.cancel();

        // Assert
        expect(emittedValues.length, equals(2));

        // First emission: [ReadingData('1', 'Book 1', 'thumb1.jpg', 0.5)] -> [ReadingDomain]
        expect(emittedValues[0].length, equals(1));
        expect(emittedValues[0][0].bookId, equals('1'));
        expect(emittedValues[0][0].bookName, equals('Book 1'));

        // Second emission: [ReadingData('1', ...), ReadingData('2', ...)] -> [ReadingDomain, ReadingDomain]
        expect(emittedValues[1].length, equals(2));
        expect(emittedValues[1][0].bookId, equals('1'));
        expect(emittedValues[1][1].bookId, equals('2'));

        verify(mockIReadingDataSource.watchReadingData()).called(1);
      },
    );

    test('should handle errors from data source stream', () async {
      // Arrange
      final errorStream = Stream<List<ReadingData>>.error(
        Exception('Data source error'),
      );
      when(
        mockIReadingDataSource.watchReadingData(),
      ).thenAnswer((_) => errorStream);

      // Act & Assert
      expect(
        () => sut.watchReadings().first,
        throwsA(isA<Exception>()),
      );
      verify(mockIReadingDataSource.watchReadingData()).called(1);
    });

    test('should handle empty lists from data source', () async {
      // Arrange
      final emptyStream = Stream.fromIterable([
        <ReadingData>[],
        <ReadingData>[],
      ]);
      when(
        mockIReadingDataSource.watchReadingData(),
      ).thenAnswer((_) => emptyStream);

      // Act
      final emittedValues = <List<ReadingDomain>>[];
      final subscription = sut.watchReadings().listen(
        (data) => emittedValues.add(data),
      );

      await Future.delayed(Duration.zero);
      await subscription.cancel();

      // Assert
      expect(emittedValues.length, equals(2));
      expect(emittedValues[0], isEmpty);
      expect(emittedValues[1], isEmpty);
      verify(mockIReadingDataSource.watchReadingData()).called(1);
    });

    test(
      'should transform single ReadingData to single ReadingDomain',
      () async {
        // Arrange
        final singleData = ReadingData('3', 'Book 3', 'thumb3.jpg', 0.3);
        final singleStream = Stream.fromIterable([
          [singleData],
        ]);
        when(
          mockIReadingDataSource.watchReadingData(),
        ).thenAnswer((_) => singleStream);

        // Act
        final result = await sut.watchReadings().first;

        // Assert
        expect(result.length, equals(1));
        expect(result[0].bookId, equals('3'));
        expect(result[0].bookName, equals('Book 3'));
        expect(result[0].bookThumb, equals('thumb3.jpg'));
        expect(result[0].progress, equals(0.3));
        verify(mockIReadingDataSource.watchReadingData()).called(1);
      },
    );
  });
}
