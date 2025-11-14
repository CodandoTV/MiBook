import 'package:mibook/layers/domain/models/book_list_domain.dart';

abstract class IFavoriteRepository {
  Future<void> setFavoriteStatus(BookDomain book, bool isFavorite);
  Future<bool> getFavoriteStatus(String bookId);
  Future<List<BookDomain>> getFavoriteBooks();
}
