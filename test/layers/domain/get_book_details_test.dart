import 'package:flutter_test/flutter_test.dart';
import 'package:mibook/layers/domain/repository/search_repository.dart';
import 'package:mibook/layers/domain/usecases/get_book_details.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'fakes/fake_book_domain.dart';

@GenerateNiceMocks([MockSpec<ISearchRepository>()])
import 'get_book_details_test.mocks.dart';

void main() {
  late MockISearchRepository mockSearchRepository;
  late GetBookDetails getBookDetails;

  setUp(() {
    mockSearchRepository = MockISearchRepository();
    getBookDetails = GetBookDetails(
      mockSearchRepository,
    );
  });

  group('GetBookDetails', () {
    test('call returns BookDetails on success', () async {
      when(
        mockSearchRepository.searchById(
          id: 'id',
        ),
      ).thenAnswer((_) async => Future.value(fakeBookDomain));

      final result = await getBookDetails.call(id: 'id');
      expect(result, fakeBookDomain);
    });

    test('call returns BookDetails on failure', () async {
      when(
        mockSearchRepository.searchById(
          id: 'id',
        ),
      ).thenThrow(Exception('Something went wrong'));

      var error = false;
      try {
        await getBookDetails.call(id: 'id');
        error = false;
      } catch (e) {
        error = true;
      }

      expect(error, isTrue);
    });
  });
}
