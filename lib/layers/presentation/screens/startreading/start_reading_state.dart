import 'package:freezed_annotation/freezed_annotation.dart';
part 'start_reading_state.freezed.dart';

@freezed
class StartReadingState with _$StartReadingState {
  const factory StartReadingState({
    String? inputErrorMessage,
    @Default(0.0) double progress,
    @Default(false) bool shouldNavigateBack,
    @Default(false) bool shouldShowSavingError,
  }) = _StartReadingState;

  factory StartReadingState.initial() => const StartReadingState();
}
