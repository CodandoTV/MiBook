import 'package:injectable/injectable.dart';
import 'package:mibook/layers/data/datasource/favorite_data_source.dart';
import 'package:mibook/layers/data/models/book_list_data.dart';
import 'package:mibook/layers/domain/models/book_list_domain.dart';
import 'package:mibook/layers/domain/repository/favorite_repository.dart';

@LazySingleton(as: IFavoriteRepository)
class FavoriteRepository implements IFavoriteRepository {
  final IFavoriteDataSource _dataSource;

  FavoriteRepository(this._dataSource);

  @override
  Future<List<BookDomain>> getFavoriteBooks() async =>
      _dataSource.getFavoriteBooks().then(
        (dataBooks) => dataBooks.map((e) => e.toDomain()).toList(),
      );

  @override
  Future<bool> getFavoriteStatus(String bookId) async =>
      _dataSource.getFavoriteStatus(bookId);

  @override
  Future<void> setFavoriteStatus(BookDomain book, bool isFavorite) async =>
      _dataSource.setFavoriteStatus(BookItem.fromDomain(book), isFavorite);
}
