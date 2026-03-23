import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mibook/layers/domain/models/book_list_domain.dart';
part 'favorite_item_ui.freezed.dart';

@freezed
class FavoriteItemUI with _$FavoriteItemUI {
  const FavoriteItemUI._();

  const factory FavoriteItemUI({
    @Default('') id,
    @Default('') kind,
    @Default('') title,
    @Default('') authors,
    @Default('') description,
    thumbnail,
  }) = _FavoriteItemUI;

  BookDomain get toDomain => BookDomain(
    id: id,
    kind: kind,
    title: title,
    authors: authors.isNotEmpty ? authors.split(', ') : [],
    description: description,
    thumbnail: thumbnail,
  );

  factory FavoriteItemUI.fromDomain(BookDomain domain) {
    return FavoriteItemUI(
      id: domain.id,
      kind: domain.kind,
      title: domain.title,
      authors: domain.authors.join(', '),
      description: domain.description ?? '',
      thumbnail: domain.thumbnail,
    );
  }
}
