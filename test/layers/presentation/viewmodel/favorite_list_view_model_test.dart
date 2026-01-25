import 'package:flutter_test/flutter_test.dart';
import 'package:mibook/layers/domain/usecases/get_favorite_list.dart';
import 'package:mibook/layers/domain/usecases/set_favorite.dart';
import 'package:mibook/layers/presentation/screens/favoritelist/favorite_list_event.dart';
import 'package:mibook/layers/presentation/screens/favoritelist/favorite_list_state.dart';
import 'package:mibook/layers/presentation/screens/favoritelist/favorite_list_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../domain/fakes/fake_book_domain.dart';
import '../../domain/fakes/fake_favorite_ui.dart';
@GenerateNiceMocks([
  MockSpec<IGetFavoriteList>(),
  MockSpec<ISetFavorite>(),
])
import 'favorite_list_view_model_test.mocks.dart';

void main() {
  late MockIGetFavoriteList mockGetFavoriteList;
  late MockISetFavorite mockSetFavorite;
  late FavoriteListViewModel sut;

  setUp() {
    mockGetFavoriteList = MockIGetFavoriteList();
    mockSetFavorite = MockISetFavorite();
    sut = FavoriteListViewModel(
      mockGetFavoriteList,
      mockSetFavorite,
    );
  }

  group('test FavoriteListViewModel', () {
    setUp();

    test('DidAppearEvent', () async {
      when(
        mockGetFavoriteList(),
      ).thenAnswer((_) async => [fakeBookDomain]);
      sut.add(DidAppearEvent());
      await expectLater(
        sut.stream,
        emits(
          predicate<FavoriteListState>(
            (state) =>
                state.books.length == 1 &&
                state.books.first.id == fakeFavoriteUI.id,
          ),
        ),
      );
      verify(mockGetFavoriteList()).called(1);
    });
  });
}
