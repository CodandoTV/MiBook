import 'package:mibook/layers/domain/models/book_list_domain.dart';
import 'package:mibook/layers/domain/repository/search_repository.dart';

abstract class ISearchBooks {
  Future<BookListDomain> search({
    required String initTitle,
  });
}

class SearchBooks implements ISearchBooks {
  final ISearchRepository _repository;

  SearchBooks(this._repository);

  @override
  Future<BookListDomain> search({
    required String initTitle,
  }) async {
    return await _repository.searchByTitle(initTitle: initTitle);
  }
}
