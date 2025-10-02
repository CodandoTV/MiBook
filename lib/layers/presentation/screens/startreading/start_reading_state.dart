import 'package:freezed_annotation/freezed_annotation.dart';
part 'start_reading_state.freezed.dart';

@freezed
class StartReadingState with _$StartReadingState {
  @override
  final String? inputErrorMessage;
  @override
  final double progress;
  @override
  final bool shouldNavigateBack;

  StartReadingState({
    required this.inputErrorMessage,
    required this.progress,
    required this.shouldNavigateBack,
  });

  static StartReadingState get initial => StartReadingState(
    inputErrorMessage: null,
    progress: 0.0,
    shouldNavigateBack: false,
  );
}
