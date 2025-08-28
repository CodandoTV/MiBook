abstract class BookSearchEvent {}

class DidClickSearchEvent extends BookSearchEvent {}

class DidLoadEvent extends BookSearchEvent {}

class DidChangeSearchTextEvent extends BookSearchEvent {
  final String text;
  DidChangeSearchTextEvent(this.text);
}
