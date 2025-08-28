import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mibook/layers/presentation/screens/booksearch/book_ui.dart';

part 'book_search_state.freezed.dart';

@freezed
class BookSearchState with _$BookSearchState {
  const factory BookSearchState({
    required bool isLoading,
    String? errorMessage,
    required String searchText,
    required List<BookUI> books,
  }) = _BookSearchState;

  factory BookSearchState.initial() => const BookSearchState(
    isLoading: false,
    errorMessage: null,
    searchText: '',
    books: [],
  );
}
