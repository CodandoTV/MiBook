import 'package:injectable/injectable.dart';
import 'package:mibook/layers/data/api/api_client.dart';
import 'package:mibook/layers/data/models/book_list_data.dart';

abstract class ISearchDataSource {
  Future<BookListData> searchByTitle({
    required String initTitle,
    required int startIndex,
  });
  Future<BookItem> searchById({
    required String id,
  });
}

@Injectable(as: ISearchDataSource)
class SearchDataSource implements ISearchDataSource {
  final IApiClient _apiClient;

  SearchDataSource(this._apiClient);

  @override
  Future<BookListData> searchByTitle({
    required String initTitle,
    required int startIndex,
  }) async {
    final response = await _apiClient.get(
      endpoint: 'volumes',
      queryParameters: {
        'q': 'intitle:$initTitle',
        'startIndex': startIndex,
        'maxResults': 40,
      },
    );
    final data = BookListData.fromJson(response);
    return data;
  }

  @override
  Future<BookItem> searchById({
    required String id,
  }) async {
    final response = await _apiClient.get(
      endpoint: 'volumes/$id',
    );
    final data = BookItem.fromJson(response);
    return data;
  }
}
