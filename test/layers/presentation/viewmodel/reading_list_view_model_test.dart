@GenerateNiceMocks(
  [
    MockSpec<IGetReadings>(),
  ],
)
import 'package:flutter_test/flutter_test.dart';
import 'package:mibook/layers/domain/usecases/get_readings.dart';
import 'package:mibook/layers/presentation/screens/readinglist/reading_list_event.dart';
import 'package:mibook/layers/presentation/screens/readinglist/reading_list_state.dart';
import 'package:mibook/layers/presentation/screens/readinglist/reading_list_ui.dart';
import 'package:mibook/layers/presentation/screens/readinglist/reading_list_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../domain/fakes/fake_reading_domain.dart';
import 'reading_list_view_model_test.mocks.dart';

void main() {
  late MockIGetReadings mockGetReadings;
  late ReadingListViewModel viewModel;

  setUp(() {
    mockGetReadings = MockIGetReadings();
    viewModel = ReadingListViewModel(mockGetReadings);
  });

  tearDown(() {
    viewModel.close();
  });

  final expectedReadingUIs = fakeReadingDomains
      .map((e) => ReadingUI.fromDomain(e))
      .toList();

  group('ReadingListViewModel', () {
    test('should initialize with empty state', () {
      // Assert
      expect(viewModel.state, equals(ReadingListState()));
      expect(viewModel.state.readings, isEmpty);
    });

    test('should load reading list successfully', () async {
      // Arrange
      when(mockGetReadings()).thenAnswer((_) async => fakeReadingDomains);

      // Act
      viewModel.add(LoadReadingListEvent());
      await viewModel.stream.firstWhere(
        (state) => state.readings.isNotEmpty,
      );

      // Assert
      expect(viewModel.state.readings, equals(expectedReadingUIs));
      verify(mockGetReadings()).called(1);
    });

    test('should handle empty reading list', () async {
      // Arrange
      when(mockGetReadings()).thenAnswer((_) async => []);

      // Act
      viewModel.add(LoadReadingListEvent());
      await viewModel.stream.first;

      // Assert
      expect(viewModel.state.readings, isEmpty);
      verify(mockGetReadings()).called(1);
    });

    test('should convert ReadingDomain to ReadingUI correctly', () async {
      // Arrange
      when(mockGetReadings()).thenAnswer((_) async => fakeReadingDomains);

      // Act
      viewModel.add(LoadReadingListEvent());
      await viewModel.stream.firstWhere(
        (state) => state.readings.isNotEmpty,
      );

      // Assert
      final firstReading = viewModel.state.readings.first;
      final firstDomain = fakeReadingDomains.first;

      expect(firstReading.bookId, equals(firstDomain.bookId));
      expect(firstReading.bookName, equals(firstDomain.bookName));
      expect(firstReading.bookThumb, equals(firstDomain.bookThumb));
      expect(firstReading.progress, equals(firstDomain.progress));
    });
  });
}
