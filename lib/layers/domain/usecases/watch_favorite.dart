import 'package:injectable/injectable.dart';
import 'package:mibook/layers/domain/models/book_list_domain.dart';
import 'package:mibook/layers/domain/repository/favorite_repository.dart';

abstract class IWatchFavorite {
  Stream<List<BookDomain>> call();
}

@Injectable(as: IWatchFavorite)
class WatchFavorite implements IWatchFavorite {
  final IFavoriteRepository _favoriteRepository;

  WatchFavorite(this._favoriteRepository);

  @override
  Stream<List<BookDomain>> call() => _favoriteRepository.watchFavoriteBooks();
}
