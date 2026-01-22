@GenerateNiceMocks([MockSpec<IReadingRepository>()])
import 'package:flutter_test/flutter_test.dart';
import 'package:mibook/layers/domain/repository/reading_repository.dart';
import 'package:mibook/layers/domain/usecases/get_readings.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fakes/fake_reading_domain.dart';
import 'get_readings_test.mocks.dart';

void main() {
  late MockIReadingRepository mockRepository;
  late GetReadings getReadings;

  setUp(() {
    mockRepository = MockIReadingRepository();
    getReadings = GetReadings(mockRepository);
  });

  group('GetReadings', () {
    test('should return the expected list on successful call', () async {
      // Arrange
      when(
        mockRepository.getReadings(),
      ).thenAnswer((_) async => fakeReadingDomains);

      // Act
      final result = await getReadings.call();

      // Assert
      expect(result, equals(fakeReadingDomains));
      verify(mockRepository.getReadings()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should throw exception when repository throws', () async {
      // Arrange
      final exception = Exception('Repository error');
      when(mockRepository.getReadings()).thenThrow(exception);

      // Act & Assert
      expect(() async => await getReadings.call(), throwsA(exception));
      verify(mockRepository.getReadings()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test(
      'should return empty list when repository returns empty list',
      () async {
        // Arrange
        when(mockRepository.getReadings()).thenAnswer((_) async => []);

        // Act
        final result = await getReadings.call();

        // Assert
        expect(result, isEmpty);
        verify(mockRepository.getReadings()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test('should handle multiple calls without side effects', () async {
      // Arrange
      when(
        mockRepository.getReadings(),
      ).thenAnswer((_) async => fakeReadingDomains);

      // Act
      final result1 = await getReadings.call();
      final result2 = await getReadings.call();
      final result3 = await getReadings.call();

      // Assert
      expect(result1, equals(fakeReadingDomains));
      expect(result2, equals(fakeReadingDomains));
      expect(result3, equals(fakeReadingDomains));
      verify(mockRepository.getReadings()).called(3);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
