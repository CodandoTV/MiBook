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

  setUp() {
    mockIReadingDataSource = MockIReadingDataSource();
    sut = ReadingRepository(mockIReadingDataSource);
  }

  group('test ReadingRepository', () {
    setUp();

    test('startReading', () async {
      final readingDomain = ReadingDomain(bookId: 'id1', progress: 0.5);
      final readingData = ReadingData(bookId: 'id1', progress: 0.5);

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
      ReadingData(bookId: 'id1', progress: 0.5),
      ReadingData(bookId: 'id2', progress: 0.5),
    ];

    when(
      mockIReadingDataSource.getReadingData(),
    ).thenAnswer((_) async => fakeData);

    final response = await sut.getReadings();

    verify(mockIReadingDataSource.getReadingData()).called(1);
    expect(response.length, 2);
  });
}
