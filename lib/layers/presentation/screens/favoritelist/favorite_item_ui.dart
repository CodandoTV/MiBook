import 'package:mibook/layers/domain/models/book_list_domain.dart';

class FavoriteItemUI {
  final String id;
  final String kind;
  final String title;
  final String authors;
  final String description;
  final String? thumbnail;

  FavoriteItemUI({
    required this.id,
    required this.kind,
    required this.title,
    required this.authors,
    required this.description,
    required this.thumbnail,
  });

  factory FavoriteItemUI.fromDomain(BookDomain domain) {
    return FavoriteItemUI(
      id: domain.id,
      kind: domain.kind,
      title: domain.title,
      authors: (domain.authors).join(', '),
      description: domain.description ?? '',
      thumbnail: domain.thumbnail,
    );
  }

  BookDomain get toDomain => BookDomain(
    id: id,
    kind: kind,
    title: title,
    authors: authors.isNotEmpty ? authors.split(', ') : [],
    description: description,
    thumbnail: thumbnail,
    pageCount: 0,
  );
}
