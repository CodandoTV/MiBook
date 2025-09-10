import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mibook/layers/domain/usecases/get_book_details.dart';
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_event.dart';
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_state.dart';
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_ui.dart';

@injectable
class BookDetailsViewModel extends Bloc<BookDetailsEvent, BookDetailsState> {
  final IGetBookDetails _getBookDetails;
  String? bookId;

  BookDetailsViewModel(
    this._getBookDetails,
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
    on<DidClickStartReadingEvent>((event, emit) async {
      // Handle start reading event
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
}
