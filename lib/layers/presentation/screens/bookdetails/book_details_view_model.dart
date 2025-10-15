import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mibook/layers/domain/models/reading_domain.dart';
import 'package:mibook/layers/domain/usecases/get_book_details.dart';
import 'package:mibook/layers/domain/usecases/start_reading.dart';
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_event.dart';
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_state.dart';
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_ui.dart';

@injectable
class BookDetailsViewModel extends Bloc<BookDetailsEvent, BookDetailsState> {
  final IGetBookDetails _getBookDetails;
  final IStartReading _startReading;
  String? bookId;

  BookDetailsViewModel(
    this._getBookDetails,
    this._startReading,
    @factoryParam this.bookId,
  ) : super(BookDetailsState.initial()) {
    on<DidLoadEvent>((event, emit) async {
      emit(
        state.copyWith(
          isLoading: true,
          errorMessage: null,
        ),
      );
      try {
        final bookDetails = await loadBookDetails();
        emit(
          state.copyWith(
            isLoading: false,
            bookDetails: bookDetails,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: e.toString(),
          ),
        );
      }
    });
    on<DidClickStartReadingEvent>((event, emit) async {});
    on<DidChangeProgressTextEvent>((event, emit) {
      final pageCount = state.bookDetails?.pageCount;
      if (pageCount != null) {
        final progress = event.progress.toDouble() / pageCount.toDouble();
        emit(state.copyWith(bookProgress: progress));
      }
    });
  }

  Future<BookDetailsUI?> loadBookDetails() async {
    if (bookId != null) {
      final bookDetails = await _getBookDetails(id: bookId!);
      return BookDetailsUI.fromDomain(bookDetails);
    } else {
      return null;
    }
  }

  Future<void> startReading({required double progress}) async {
    if (bookId != null) {
      await _startReading(
        reading: ReadingDomain(
          bookId: bookId!,
          bookName: state.bookDetails?.title ?? '',
          bookThumb: state.bookDetails?.thumbnail ?? '',
          progress: progress,
        ),
      );
    }
  }
}
