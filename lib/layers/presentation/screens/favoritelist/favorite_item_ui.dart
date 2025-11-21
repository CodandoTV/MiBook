import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
}
