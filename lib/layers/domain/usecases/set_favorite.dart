import 'package:injectable/injectable.dart';
import 'package:mibook/layers/domain/models/book_list_domain.dart';
import 'package:mibook/layers/domain/repository/favorite_repository.dart';

abstract class ISetFavorite {
  Future<void> call(BookDomain book, bool isFavorite);
}

@LazySingleton(as: ISetFavorite)
class SetFavorite implements ISetFavorite {
  final IFavoriteRepository _favoriteRepository;

  SetFavorite(this._favoriteRepository);

  @override
  Future<void> call(BookDomain book, bool isFavorite) async =>
      await _favoriteRepository.setFavoriteStatus(book, isFavorite);
}
