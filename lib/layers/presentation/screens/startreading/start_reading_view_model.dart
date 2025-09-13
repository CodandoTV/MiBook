import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mibook/core/utils/strings.dart';
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
  ) : super(StartReadingState.initial) {
    on<DidEditProgressEvent>((event, emit) {
      final progress = event.progress.toDouble() / book.pageCount.toDouble();
      if (progress > 1.0) {
        emit(
          state.copyWith(
            inputErrorMessage: progressErrorMessage,
          ),
        );
      } else {
        emit(
          state.copyWith(
            progress: progress,
            inputErrorMessage: null,
          ),
        );
      }
    });
    on<DidClickConfirmEvent>((event, emit) {
      // TO DO
    });
  }
}
