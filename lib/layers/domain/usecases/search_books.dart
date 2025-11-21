import 'package:injectable/injectable.dart';
import 'package:mibook/layers/domain/models/book_list_domain.dart';
import 'package:mibook/layers/domain/repository/search_repository.dart';

abstract class ISearchBooks {
  Future<BookListDomain> call({
    required String initTitle,
    required int startIndex,
  });
}

@LazySingleton(as: ISearchBooks)
class SearchBooks implements ISearchBooks {
  final ISearchRepository _repository;

  SearchBooks(this._repository);

  @override
  Future<BookListDomain> call({
    required String initTitle,
    required int startIndex,
  }) async {
    return await _repository.searchByTitle(
      initTitle: initTitle,
      startIndex: startIndex,
    );
  }
}
