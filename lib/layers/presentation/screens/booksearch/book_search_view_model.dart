import 'package:mibook/layers/domain/usecases/search_books.dart';
import 'package:mibook/layers/presentation/screens/booksearch/book_search_event.dart';
import 'package:mibook/layers/presentation/screens/booksearch/book_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookSearchViewModel extends Bloc<BookSearchEvent, BookSearchState> {
  final ISearchBooks _searchBooks;
  BookSearchViewModel(this._searchBooks) : super(BookSearchState.initial()) {
    on<DidLoadEvent>((event, emit) async {
      await _fetchData();
    });
    on<DidChangeSearchTextEvent>((event, emit) async {
      emit(state.copyWith(searchText: event.text));
    });
  }
}
