import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mibook/layers/domain/models/reading_domain.dart';
import 'package:mibook/layers/domain/usecases/get_readings.dart';
import 'package:mibook/layers/domain/usecases/watch_readings.dart';
import 'package:mibook/layers/presentation/screens/readinglist/reading_list_event.dart';
import 'package:mibook/layers/presentation/screens/readinglist/reading_list_state.dart';
import 'package:mibook/layers/presentation/screens/readinglist/reading_list_ui.dart';

@injectable
class ReadingListViewModel extends Bloc<ReadingListEvent, ReadingListState> {
  final IGetReadings _getReadings;
  final IWatchReadings _watchReadings;

  StreamSubscription<List<ReadingDomain>>? _readingsSubscription;

  ReadingListViewModel(
    this._getReadings,
    this._watchReadings,
  ) : super(ReadingListState()) {
    on<WatchReadingListEvent>(_onWatchReadingList);
    on<RefreshReadingListEvent>(_onRefreshReadingList);
    on<RemoveReadingItemEvent>(_onRemoveReadingItem);
  }

  Future<void> _onWatchReadingList(
    WatchReadingListEvent event,
    Emitter<ReadingListState> emit,
  ) async {
    // Cancela subscription anterior se existir
    await _readingsSubscription?.cancel();

    // Usa await for para manter o handler ativo
    try {
      await for (final readingDataList in _watchReadings()) {
        final readingDomainList = readingDataList
            .map((data) => ReadingUI.fromDomain(data))
            .toList();
        emit(
          state.copyWith(
            readings: readingDomainList,
            isLoading: false,
            errorMessage: '',
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          errorMessage: error.toString(),
          isLoading: false,
        ),
      );
    }
  }

  void _onRefreshReadingList(
    RefreshReadingListEvent event,
    Emitter<ReadingListState> emit,
  ) async {
    // Implement refresh logic here
    // For example, you could re-emit the current state or fetch fresh data
    emit(state.copyWith(isLoading: true));

    try {
      final readings = await _getReadings();
      emit(
        state.copyWith(
          readings: readings.map((e) => ReadingUI.fromDomain(e)).toList(),
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          isLoading: false,
        ),
      );
    }
  }

  void _onRemoveReadingItem(
    RemoveReadingItemEvent event,
    Emitter<ReadingListState> emit,
  ) async {
    // Implement remove logic here
    // For example, remove the item from the current state
    final updatedReadings = state.readings
        .where((reading) => reading.bookId != event.bookId)
        .toList();
    emit(state.copyWith(readings: updatedReadings));
  }

  @override
  Future<void> close() {
    _readingsSubscription?.cancel();
    return super.close();
  }
}
