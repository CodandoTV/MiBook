import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mibook/layers/presentation/screens/readinglist/reading_list_ui.dart';
part 'reading_list_state.freezed.dart';

@freezed
class ReadingListState with _$ReadingListState {
  const ReadingListState._();

  const factory ReadingListState({
    @Default(false) bool isLoading,
    @Default([]) List<ReadingUI> readings,
    @Default('') String errorMessage,
  }) = _ReadingListState;
}
