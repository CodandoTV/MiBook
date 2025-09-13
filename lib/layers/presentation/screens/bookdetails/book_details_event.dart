abstract class BookDetailsEvent {}

class DidLoadEvent extends BookDetailsEvent {
  final String bookId;
  DidLoadEvent(this.bookId);
}

class DidClickStartReadingEvent extends BookDetailsEvent {
  final double progress;
  DidClickStartReadingEvent(this.progress);
}

class DidChangeProgressTextEvent extends BookDetailsEvent {
  final int progress;
  DidChangeProgressTextEvent(this.progress);
}
