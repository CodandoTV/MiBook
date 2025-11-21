import 'package:flutter_test/flutter_test.dart';
import 'package:mibook/layers/domain/usecases/get_book_details.dart';
import 'package:mibook/layers/domain/usecases/get_favorite.dart';
import 'package:mibook/layers/domain/usecases/set_favorite.dart';
import 'package:mibook/layers/domain/usecases/start_reading.dart';
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_event.dart';
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_state.dart';
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../domain/fakes/fake_book_domain.dart';
@GenerateNiceMocks(
  [
    MockSpec<ISetFavorite>(),
    MockSpec<IGetFavorite>(),
    MockSpec<IGetBookDetails>(),
    MockSpec<IStartReading>(),
  ],
)
import 'book_details_view_model_test.mocks.dart';

void main() {
  late MockISetFavorite mockSetFavorite;
  late MockIGetFavorite mockGetFavorite;
  late MockIGetBookDetails mockGetBookDetails;
  late MockIStartReading mockStartReading;
  late BookDetailsViewModel sut;

  setUp() {
    mockSetFavorite = MockISetFavorite();
    mockGetFavorite = MockIGetFavorite();
    mockGetBookDetails = MockIGetBookDetails();
    mockStartReading = MockIStartReading();
    sut = BookDetailsViewModel(
      mockGetBookDetails,
      mockStartReading,
      mockSetFavorite,
      mockGetFavorite,
      'id',
    );
  }

  group('test BookDetailsViewModel', () {
    setUp();

    test(
      'given bookId, when DidLoad called, should return favorite status',
      () async {
        when(
          mockGetFavorite('id'),
        ).thenAnswer((_) async => true);
        when(mockGetBookDetails(id: 'id')).thenAnswer(
          (_) async => fakeBookDomain,
        );
        sut.add(DidLoadEvent('id'));
        await expectLater(
          sut.stream,
          emits(
            predicate<BookDetailsState>(
              (state) => state.isFavorite,
            ),
          ),
        );
        verify(mockGetFavorite('id')).called(1);
      },
    );

    test(
      'given bookId, when DidClickFavoriteIcon called, should return favorite status',
      () async {
        when(
          mockGetFavorite('id'),
        ).thenAnswer((_) async => true);
        when(mockGetBookDetails(id: 'id')).thenAnswer(
          (_) async => fakeBookDomain,
        );
        sut.add(DidClickFavoriteIconEvent());
        await expectLater(
          sut.stream,
          emits(
            predicate<BookDetailsState>(
              (state) => !state.isFavorite,
            ),
          ),
        );
      },
    );
  });
}
