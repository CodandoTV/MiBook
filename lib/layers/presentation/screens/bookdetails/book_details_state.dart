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
  @override
  final double bookProgress;

  BookDetailsState(
    this.errorMessage,
    this.bookDetails, {
    required this.isLoading,
    required this.bookProgress,
  });

  factory BookDetailsState.initial() => BookDetailsState(
    null,
    null,
    isLoading: false,
    bookProgress: 0.0,
  );
}
