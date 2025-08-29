import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mibook/layers/presentation/screens/booksearch/book_ui.dart';

part 'book_search_state.freezed.dart';

@freezed
class BookSearchState with _$BookSearchState {
  @override
  final bool isLoading;
  @override
  final String? errorMessage;
  @override
  final String searchText;
  @override
  final List<BookUI> books;
  @override
  final bool isPageLoading;
  @override
  final bool canLoadNextPage;

  BookSearchState({
    required this.isLoading,
    required this.errorMessage,
    required this.searchText,
    required this.books,
    required this.isPageLoading,
    required this.canLoadNextPage,
  });

  factory BookSearchState.initial() => BookSearchState(
    isLoading: false,
    errorMessage: null,
    searchText: '',
    books: [],
    isPageLoading: false,
    canLoadNextPage: true,
  );
}
