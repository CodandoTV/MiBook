abstract class BookDetailsEvent {}

class DidLoadEvent extends BookDetailsEvent {
  final String bookId;
  DidLoadEvent(this.bookId);
}

class DidClickStartReadingEvent extends BookDetailsEvent {}
