import 'package:injectable/injectable.dart';
import 'package:mibook/layers/domain/models/book_list_domain.dart';
import 'package:mibook/layers/domain/repository/favorite_repository.dart';

abstract class IGetFavoriteList {
  Future<List<BookDomain>> call();
}

@Singleton(as: IGetFavoriteList)
class GetFavoriteList implements IGetFavoriteList {
  final IFavoriteRepository _favoriteRepository;

  GetFavoriteList(this._favoriteRepository);

  @override
  Future<List<BookDomain>> call() async =>
      await _favoriteRepository.getFavoriteBooks();
}
