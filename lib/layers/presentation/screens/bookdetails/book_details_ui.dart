import 'package:mibook/layers/domain/models/book_list_domain.dart';

class BookDetailsUI {
  final String id;
  final String kind;
  final String title;
  final String authors;
  final String description;
  final String? thumbnail;

  BookDetailsUI({
    required this.id,
    required this.kind,
    required this.title,
    required this.authors,
    required this.description,
    required this.thumbnail,
  });

  factory BookDetailsUI.fromDomain(BookDomain domain) {
    return BookDetailsUI(
      id: domain.id,
      kind: domain.kind,
      title: domain.title,
      authors: (domain.authors ?? []).join(', '),
      description: domain.description ?? '',
      thumbnail: domain.thumbnail,
    );
  }
}
