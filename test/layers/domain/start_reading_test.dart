@GenerateNiceMocks([MockSpec<IReadingRepository>()])
import 'package:flutter_test/flutter_test.dart';
import 'package:mibook/layers/domain/models/reading_domain.dart';
import 'package:mibook/layers/domain/repository/reading_repository.dart';
import 'package:mibook/layers/domain/usecases/start_reading.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'start_reading_test.mocks.dart';

void main() {
  late MockIReadingRepository mockIReadingRepository;
  late StartReading sut;

  setUp() {
    mockIReadingRepository = MockIReadingRepository();
    sut = StartReading(mockIReadingRepository);
  }

  group('test StartReading', () {
    setUp();

    test('start', () async {
      final readingDomain = ReadingDomain(
        bookId: 'id1',
        bookName: 'Harry Potter',
        progress: 0.5,
      );
      // when(
      //   mockIReadingRepository.startReading(reading: readingDomain),
      // ).thenAnswer((_) async => Future.value);
      await sut(reading: readingDomain);
      verify(
        mockIReadingRepository.startReading(
          reading: argThat(
            predicate<ReadingDomain>(
              (data) => data.bookId == 'id1' && data.progress == 0.5,
            ),
            named: 'reading',
          ),
        ),
      ).called(1);
    });
  });
}
