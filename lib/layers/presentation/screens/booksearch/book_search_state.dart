import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mibook/layers/presentation/screens/booksearch/book_ui.dart';

part 'book_search_state.freezed.dart';

@freezed
class BookSearchState with _$BookSearchState {
  const factory BookSearchState({
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default('') String searchText,
    @Default([]) List<BookUI> books,
    @Default(false) bool isPageLoading,
    @Default(true) bool canLoadNextPage,
  }) = _BookSearchState;

  const BookSearchState._();

  factory BookSearchState.initial() => const BookSearchState();
}
