import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mibook/layers/domain/usecases/get_favorite_list.dart';
import 'package:mibook/layers/domain/usecases/set_favorite.dart';
import 'package:mibook/layers/domain/usecases/watch_favorite.dart';
import 'package:mibook/layers/presentation/screens/favoritelist/favorite_item_ui.dart';
import 'package:mibook/layers/presentation/screens/favoritelist/favorite_list_event.dart';
import 'package:mibook/layers/presentation/screens/favoritelist/favorite_list_state.dart';

@injectable
class FavoriteListViewModel extends Bloc<FavoriteListEvent, FavoriteListState> {
  final IGetFavoriteList _getFavoriteList;
  final ISetFavorite _setFavorite;
  final IWatchFavorite _watchFavorite;
  StreamSubscription<List<FavoriteItemUI>>? _favoriteSubscription;

  FavoriteListViewModel(
    this._getFavoriteList,
    this._setFavorite,
    this._watchFavorite,
  ) : super(FavoriteListState.initial()) {
    on<DidAppearEvent>(_onWatchFavoriteList);
    on<DidTapUnfavoriteEvent>((event, emit) async {
      final result = await _unfavoriteBook(event.bookId);
      emit(result);
    });
    on<DidRefreshEvent>((event, emit) async {
      final result = await _loadFavoriteBooks();
      debugPrint('result = ${result.books.map((e) => e.thumbnail).toList()}');
      emit(result);
    });
  }

  Future<void> _onWatchFavoriteList(
    FavoriteListEvent event,
    Emitter<FavoriteListState> emit,
  ) async {
    // Cancela subscription anterior se existir
    await _favoriteSubscription?.cancel();

    // Usa await for para manter o handler ativo
    try {
      await for (final favoriteDataList in _watchFavorite()) {
        final favoriteDomainList = favoriteDataList
            .map((data) => FavoriteItemUI.fromDomain(data))
            .toList();
        emit(
          state.copyWith(
            books: favoriteDomainList,
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          errorMessage: error.toString(),
          isLoading: false,
        ),
      );
    }
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
