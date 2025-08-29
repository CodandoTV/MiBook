import 'package:injectable/injectable.dart';
import 'package:mibook/layers/data/datasource/search_data_source.dart';
import 'package:mibook/layers/domain/models/book_list_domain.dart';
import 'package:mibook/layers/domain/repository/search_repository.dart';

@Injectable(as: ISearchRepository)
class SearchRepository implements ISearchRepository {
  final ISearchDataSource _dataSource;

  SearchRepository(this._dataSource);

  @override
  Future<BookListDomain> searchByTitle({
    required String initTitle,
    required int startIndex,
  }) async {
    final data = await _dataSource.searchByTitle(
      initTitle: initTitle,
      startIndex: startIndex,
    );
    return data.toDomain();
  }
}
