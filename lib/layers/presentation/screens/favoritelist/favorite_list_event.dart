class FavoriteListEvent {}

class DidAppearEvent extends FavoriteListEvent {}

class DidTapUnfavoriteEvent extends FavoriteListEvent {
  final String bookId;

  DidTapUnfavoriteEvent(this.bookId);
}

class DidRefreshEvent extends FavoriteListEvent {}
