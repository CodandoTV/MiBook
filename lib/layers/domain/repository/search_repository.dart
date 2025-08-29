import 'package:mibook/layers/domain/models/book_list_domain.dart';

abstract class ISearchRepository {
  Future<BookListDomain> searchByTitle({
    required String initTitle,
    required int startIndex,
  });
}
