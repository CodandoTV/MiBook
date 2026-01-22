import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mibook/layers/domain/usecases/get_readings.dart';
import 'package:mibook/layers/presentation/screens/readinglist/reading_list_event.dart';
import 'package:mibook/layers/presentation/screens/readinglist/reading_list_state.dart';
import 'package:mibook/layers/presentation/screens/readinglist/reading_list_ui.dart';

@injectable
class ReadingListViewModel extends Bloc<ReadingListEvent, ReadingListState> {
  final IGetReadings _getReadings;

  ReadingListViewModel(this._getReadings) : super(ReadingListState()) {
    on<LoadReadingListEvent>((event, emit) {
      _loadReadingList().then((state) => emit(state));
    });
    on<RefreshReadingListEvent>((event, emit) {});
    on<RemoveReadingItemEvent>((event, emit) {});
  }

  Future<ReadingListState> _loadReadingList() async {
    final readings = await _getReadings();
    return state.copyWith(
      readings: readings
          .map(
            (e) => ReadingUI.fromDomain(e),
          )
          .toList(),
    );
  }
}
