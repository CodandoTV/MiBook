import 'package:injectable/injectable.dart';
import 'package:mibook/layers/domain/usecases/search_books.dart';
import 'package:mibook/layers/presentation/screens/booksearch/book_search_event.dart';
import 'package:mibook/layers/presentation/screens/booksearch/book_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mibook/layers/presentation/screens/booksearch/book_ui.dart';

@injectable
class BookSearchViewModel extends Bloc<BookSearchEvent, BookSearchState> {
  final ISearchBooks _searchBooks;
  int currentIndex = 0;

  BookSearchViewModel(this._searchBooks) : super(BookSearchState.initial()) {
    on<DidChangeSearchTextEvent>((event, emit) async {
      emit(state.copyWith(searchText: event.text));
    });
    on<DidClickSearchEvent>((event, emit) async {
      currentIndex = 0;
      emit(
        state.copyWith(
          isLoading: true,
          errorMessage: null,
          books: [],
          canLoadNextPage: true,
        ),
      );
      final response = await _search(state.searchText);
      emit(
        state.copyWith(
          books: response,
          isLoading: false,
        ),
      );
    });
    on<DidFinishPageEvent>((event, emit) async {
      if (state.isLoading) return;
      currentIndex += 100;
      emit(
        state.copyWith(
          isPageLoading: true,
          errorMessage: null,
          canLoadNextPage: false,
        ),
      );
      try {
        final response = await _search(state.searchText);
        final updatedBooks = List<BookUI>.from(state.books)..addAll(response);
        emit(
          state.copyWith(
            books: updatedBooks,
            isPageLoading: false,
            canLoadNextPage: response.isNotEmpty,
          ),
        );
      } catch (e) {
        print('Error during pagination: $e');
        emit(
          state.copyWith(
            isPageLoading: false,
            canLoadNextPage: false,
          ),
        );
      }
    });
  }

  Future<List<BookUI>> _search(String initTitle) async {
    final response = await _searchBooks.search(
      initTitle: initTitle,
      startIndex: currentIndex,
    );
    final books = response.books
        .map((elem) => BookUI.fromDomain(elem))
        .toList();
    return books;
  }
}
