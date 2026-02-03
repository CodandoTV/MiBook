class ReadingListEvent {}

class WatchReadingListEvent extends ReadingListEvent {}

class RefreshReadingListEvent extends ReadingListEvent {}

class RemoveReadingItemEvent extends ReadingListEvent {
  final String bookId;
  RemoveReadingItemEvent(this.bookId);
}
