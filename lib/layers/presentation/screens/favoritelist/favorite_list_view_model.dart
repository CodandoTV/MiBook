import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mibook/layers/domain/usecases/get_favorite_list.dart';
import 'package:mibook/layers/domain/usecases/set_favorite.dart';
import 'package:mibook/layers/presentation/screens/favoritelist/favorite_item_ui.dart';
import 'package:mibook/layers/presentation/screens/favoritelist/favorite_list_event.dart';
import 'package:mibook/layers/presentation/screens/favoritelist/favorite_list_state.dart';

class FavoriteListViewModel extends Bloc<FavoriteListEvent, FavoriteListState> {
  final IGetFavoriteList _getFavoriteList;
  final ISetFavorite _setFavorite;

  FavoriteListViewModel(
    this._getFavoriteList,
    this._setFavorite,
  ) : super(FavoriteListState.initial()) {
    on<DidAppearEvent>((event, emit) async {
      final result = await _loadFavoriteBooks();
      emit(result);
    });
    on<DidTapUnfavoriteEvent>((event, emit) async {
      final result = await _unfavoriteBook(event.bookId);
      emit(result);
    });
  }

  Future<FavoriteListState> _loadFavoriteBooks() async {
    final favoriteBooks = await _getFavoriteList();
    final favoriteItemsUI = favoriteBooks
        .map(
          (elem) => FavoriteItemUI(
            id: elem.id,
            kind: elem.kind,
            title: elem.title,
            authors: (elem.authors).join(', '),
            description: elem.description ?? '',
            thumbnail: elem.thumbnail,
          ),
        )
        .toList();
    return state.copyWith(books: favoriteItemsUI);
  }

  Future<FavoriteListState> _unfavoriteBook(String bookId) async {
    final book = state.books.firstWhere((book) => book.id == bookId);
    await _setFavorite(book.toDomain, false);
    return _loadFavoriteBooks();
  }
}
