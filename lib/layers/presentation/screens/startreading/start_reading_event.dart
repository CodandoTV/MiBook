abstract class StartReadingEvent {}

class DidEditProgressEvent extends StartReadingEvent {
  int progress;
  DidEditProgressEvent({required this.progress});
}

class DidClickConfirmEvent extends StartReadingEvent {}
