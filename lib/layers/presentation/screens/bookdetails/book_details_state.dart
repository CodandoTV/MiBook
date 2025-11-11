import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_ui.dart';
part 'book_details_state.freezed.dart';

@freezed
class BookDetailsState with _$BookDetailsState {
  const factory BookDetailsState({
    String? errorMessage,
    BookDetailsUI? bookDetails,
    @Default(false) bool isLoading,
    @Default(0.0) double bookProgress,
  }) = _BookDetailsState;

  const BookDetailsState._(); // allows adding custom getters or methods later

  factory BookDetailsState.initial() => const BookDetailsState();
}
