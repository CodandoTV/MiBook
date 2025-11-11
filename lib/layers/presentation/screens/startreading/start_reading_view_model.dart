import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mibook/core/utils/strings.dart';
import 'package:mibook/layers/domain/models/reading_domain.dart';
import 'package:mibook/layers/domain/usecases/start_reading.dart';
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_ui.dart';
import 'package:mibook/layers/presentation/screens/startreading/start_reading_event.dart';
import 'package:mibook/layers/presentation/screens/startreading/start_reading_state.dart';

@injectable
class StartReadingViewModel extends Bloc<StartReadingEvent, StartReadingState> {
  final IStartReading _startReading;
  final BookDetailsUI book;

  StartReadingViewModel(
    this._startReading,
    @factoryParam this.book,
  ) : super(StartReadingState.initial()) {
    // Handle DidEditProgress Event
    on<DidEditProgressEvent>((event, emit) {
      emit(_didEditProgress(event));
    });
    // Handle DidClickConfirm Event
    on<DidClickConfirmEvent>((event, emit) async {
      final response = await _didClickConfirm();
      emit(response);
    });
    // Handle DidFinishBook Event
    on<DidClickFinishBookEvent>((event, emit) async {
      final response = await _didClickFinishBook();
      emit(response);
    });
  }

  // Event Handler to DidEditProgressEvent
  StartReadingState _didEditProgress(DidEditProgressEvent event) {
    final progress = event.progress.toDouble() / book.pageCount.toDouble();
    if (progress > 1.0) {
      return state.copyWith(
        inputErrorMessage: progressErrorMessage,
      );
    } else {
      return state.copyWith(
        progress: progress,
        inputErrorMessage: null,
      );
    }
  }

  // Event Handler to DidClickConfirm Event
  Future<StartReadingState> _didClickConfirm() async =>
      _handleStartReading(state.progress);

  // Event Handler to DidClickFinishBook Event
  Future<StartReadingState> _didClickFinishBook() async =>
      _handleStartReading(1.0);

  Future<StartReadingState> _handleStartReading(double progress) async {
    final reading = ReadingDomain(
      bookId: book.id,
      bookName: book.title,
      bookThumb: book.thumbnail,
      progress: progress,
    );
    await _startReading(reading: reading);
    return state.copyWith(shouldNavigateBack: true);
  }
}
