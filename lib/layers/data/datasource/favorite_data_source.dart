import 'package:injectable/injectable.dart';
import 'package:mibook/layers/data/api/storage_client.dart';
import 'package:mibook/layers/data/models/book_list_data.dart';

abstract class IFavoriteDataSource {
  Future<void> setFavoriteStatus(BookItem book, bool isFavorite);
  Future<bool> getFavoriteStatus(String bookId);
  Future<List<BookItem>> getFavoriteBooks();
}

@LazySingleton(as: IFavoriteDataSource)
class FavoriteDataSource implements IFavoriteDataSource {
  final IStorageClient storageClient;

  FavoriteDataSource(this.storageClient);

  @override
  Future<void> setFavoriteStatus(BookItem book, bool isFavorite) async {
    await storageClient.setFavoriteStatus(book, isFavorite);
  }

  @override
  Future<bool> getFavoriteStatus(String bookId) async {
    return await storageClient.getFavoriteStatus(bookId);
  }

  @override
  Future<List<BookItem>> getFavoriteBooks() async {
    return await storageClient.getFavoriteBooks();
  }
}
