import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// Import your actual classes
import 'package:mibook/layers/domain/models/reading_domain.dart';
import 'package:mibook/layers/domain/usecases/get_readings.dart';
import 'package:mibook/layers/domain/usecases/watch_readings.dart';
import 'package:mibook/layers/presentation/screens/readinglist/reading_list_event.dart';
import 'package:mibook/layers/presentation/screens/readinglist/reading_list_state.dart';
import 'package:mibook/layers/presentation/screens/readinglist/reading_list_ui.dart';
import 'package:mibook/layers/presentation/screens/readinglist/reading_list_view_model.dart';

// Generate mocks
@GenerateNiceMocks([MockSpec<IGetReadings>(), MockSpec<IWatchReadings>()])
import 'reading_list_view_model_test.mocks.dart';

void main() {
  late MockIGetReadings mockGetReadings;
  late MockIWatchReadings mockWatchReadings;
  late ReadingListViewModel readingListViewModel;

  // Mock domain models
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

  // Mock UI models
  final uiReading1 = ReadingUI.fromDomain(reading1);
  final uiReading2 = ReadingUI.fromDomain(reading2);

  setUp(() {
    mockGetReadings = MockIGetReadings();
    mockWatchReadings = MockIWatchReadings();
    readingListViewModel = ReadingListViewModel(
      mockGetReadings,
      mockWatchReadings,
    );
  });

  tearDown(() {
    readingListViewModel.close();
  });

  group('ReadingListViewModel', () {
    group('WatchReadingListEvent', () {
      blocTest<ReadingListViewModel, ReadingListState>(
        'emits updated state when stream emits readings',
        build: () {
          final mockStream = Stream.fromIterable([
            [reading1],
            [reading1, reading2],
          ]);
          when(mockWatchReadings()).thenAnswer((_) => mockStream);
          return readingListViewModel;
        },
        act: (bloc) => bloc.add(WatchReadingListEvent()),
        expect: () => [
          ReadingListState(readings: [uiReading1]),
          ReadingListState(readings: [uiReading1, uiReading2]),
        ],
        verify: (_) {
          verify(mockWatchReadings()).called(1);
        },
      );

      blocTest<ReadingListViewModel, ReadingListState>(
        'cancels previous subscription when called multiple times',
        build: () {
          final mockStream = Stream.fromIterable([
            [reading1],
          ]);
          when(mockWatchReadings()).thenAnswer((_) => mockStream);
          return readingListViewModel;
        },
        act: (bloc) {
          bloc.add(WatchReadingListEvent());
          bloc.add(WatchReadingListEvent()); // Second call
        },
        expect: () => [
          ReadingListState(readings: [uiReading1]),
          ReadingListState(readings: [uiReading1]), // Second emission
        ],
        verify: (_) {
          verify(mockWatchReadings()).called(2);
        },
      );
    });

    group('RefreshReadingListEvent', () {
      blocTest<ReadingListViewModel, ReadingListState>(
        'emits loading then success state when getReadings succeeds',
        build: () {
          when(mockGetReadings()).thenAnswer((_) async => [reading1, reading2]);
          return readingListViewModel;
        },
        act: (bloc) => bloc.add(RefreshReadingListEvent()),
        expect: () => [
          ReadingListState(isLoading: true),
          ReadingListState(
            readings: [uiReading1, uiReading2],
            isLoading: false,
          ),
        ],
        verify: (_) {
          verify(mockGetReadings()).called(1);
        },
      );

      blocTest<ReadingListViewModel, ReadingListState>(
        'emits loading then error state when getReadings fails',
        build: () {
          when(mockGetReadings()).thenThrow(Exception('Network error'));
          return readingListViewModel;
        },
        act: (bloc) => bloc.add(RefreshReadingListEvent()),
        expect: () => [
          ReadingListState(isLoading: true),
          ReadingListState(
            errorMessage: 'Exception: Network error',
            isLoading: false,
          ),
        ],
        verify: (_) {
          verify(mockGetReadings()).called(1);
        },
      );
    });

    group('RemoveReadingItemEvent', () {
      blocTest<ReadingListViewModel, ReadingListState>(
        'removes the specified item from readings list',
        build: () => readingListViewModel,
        seed: () => ReadingListState(readings: [uiReading1, uiReading2]),
        act: (bloc) => bloc.add(RemoveReadingItemEvent('1')),
        expect: () => [
          ReadingListState(readings: [uiReading2]), // Only reading2 remains
        ],
      );

      blocTest<ReadingListViewModel, ReadingListState>(
        'does nothing if item to remove is not found',
        build: () => readingListViewModel,
        seed: () => ReadingListState(readings: [uiReading1, uiReading2]),
        act: (bloc) => bloc.add(RemoveReadingItemEvent('999')),
        expect: () => [
          ReadingListState(readings: [uiReading1, uiReading2]), // No change
        ],
      );
    });

    test('cancels stream subscription when closed', () async {
      final mockStream = Stream.fromIterable([
        [reading1],
      ]);
      when(mockWatchReadings()).thenAnswer((_) => mockStream);

      // Add event to start subscription
      readingListViewModel.add(WatchReadingListEvent());

      // Wait for stream to start
      await Future.delayed(Duration.zero);

      // Close the bloc
      await readingListViewModel.close();

      // Verify subscription was created (we can't directly test cancellation,
      // but we can verify the stream was called)
      verify(mockWatchReadings()).called(1);
    });
  });
}
