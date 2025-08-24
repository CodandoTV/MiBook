import 'package:mibook/layers/data/api/api_client.dart';
import 'package:mibook/layers/data/models/book_list_data.dart';

abstract class ISearchDataSource {
  Future<BookListData> searchByTitle({
    required String initTitle,
  });
}

class SearchDataSource implements ISearchDataSource {
  final IApiClient _apiClient;

  SearchDataSource(this._apiClient);

  @override
  Future<BookListData> searchByTitle({
    required String initTitle,
  }) async {
    final response = await _apiClient.get(
      endpoint: 'volumes',
      queryParameters: {
        'q': 'intitle:$initTitle',
      },
    );
    final data = BookListData.fromJson(response);
    return data;
  }
}
