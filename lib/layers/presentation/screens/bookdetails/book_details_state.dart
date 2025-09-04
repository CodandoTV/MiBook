import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_ui.dart';
part 'book_details_state.freezed.dart';

@freezed
class BookDetailsState with _$BookDetailsState {
  @override
  final bool isLoading;
  @override
  final String? errorMessage;
  @override
  final BookDetailsUI? bookDetails;

  BookDetailsState(
    this.errorMessage,
    this.bookDetails, {
    required this.isLoading,
  });

  factory BookDetailsState.initial() => BookDetailsState(
    null,
    null,
    isLoading: false,
  );
}
