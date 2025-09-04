import 'package:injectable/injectable.dart';
import 'package:mibook/layers/domain/models/book_list_domain.dart';
import 'package:mibook/layers/domain/repository/search_repository.dart';

abstract class IGetBookDetails {
  Future<BookDomain> call({required String id});
}

@Injectable(as: IGetBookDetails)
class GetBookDetails implements IGetBookDetails {
  final ISearchRepository _repository;

  GetBookDetails(this._repository);

  @override
  Future<BookDomain> call({required String id}) async {
    return await _repository.searchById(id: id);
  }
}
