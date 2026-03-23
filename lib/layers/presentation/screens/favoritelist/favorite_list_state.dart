import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mibook/layers/presentation/screens/favoritelist/favorite_item_ui.dart';
part 'favorite_list_state.freezed.dart';

@freezed
class FavoriteListState with _$FavoriteListState {
  const factory FavoriteListState({
    @Default([]) List<FavoriteItemUI> books,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _FavoriteListState;

  const FavoriteListState._();

  factory FavoriteListState.initial() => const FavoriteListState();
}
