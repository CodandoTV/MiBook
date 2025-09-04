class BookDetailsDomain {
  final String id;
  final String title;
  final String authors;
  final String description;
  final String thumbnail;
  final String previewLink;

  BookDetailsDomain({
    required this.id,
    required this.title,
    required this.authors,
    required this.description,
    required this.thumbnail,
    required this.previewLink,
  });
}
