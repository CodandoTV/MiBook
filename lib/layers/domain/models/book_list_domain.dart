class BookListDomain {
  final int totalItems;
  final List<BookDomain> books;

  BookListDomain({
    required this.totalItems,
    required this.books,
  });
}

class BookDomain {
  final String id;
  final String kind;
  final String title;
  final List<String>? authors;
  final String? description;
  final String? thumbnail;

  BookDomain({
    required this.id,
    required this.kind,
    required this.title,
    required this.authors,
    required this.description,
    required this.thumbnail,
  });
}
