import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:mibook/layers/data/datasource/search_data_source.dart';
import 'package:mibook/layers/data/api/api_client.dart';
import 'package:mibook/layers/data/models/book_list_data.dart';

@GenerateNiceMocks([MockSpec<IApiClient>()])
import 'search_data_source_test.mocks.dart';

void main() {
  late MockIApiClient mockApiClient;
  late SearchDataSource dataSource;

  setUp(() {
    mockApiClient = MockIApiClient();
    dataSource = SearchDataSource(mockApiClient);
  });

  group('SearchDataSource', () {
    test('searchByTitle returns BookListData on success', () async {
      final mockJson = {
        'kind': 'books#volumes',
        'totalItems': 1,
        'items': [],
      };
      final expectedBookList = BookListData.fromJson(mockJson);

      when(
        mockApiClient.get(
          endpoint: 'volumes',
          queryParameters: {'q': 'intitle:harry potter'},
        ),
      ).thenAnswer((_) async => mockJson);

      final result = await dataSource.searchByTitle(initTitle: 'harry potter');
      expect(result.kind, expectedBookList.kind);
      expect(result.totalItems, expectedBookList.totalItems);
      expect(result.items, expectedBookList.items);
    });

    test('searchByTitle throws if apiClient throws', () async {
      when(
        mockApiClient.get(
          endpoint: 'volumes',
          queryParameters: {'q': 'intitle:harry potter'},
        ),
      ).thenThrow(Exception('API error'));

      expect(
        () => dataSource.searchByTitle(initTitle: 'harry potter'),
        throwsException,
      );
    });
  });
}
