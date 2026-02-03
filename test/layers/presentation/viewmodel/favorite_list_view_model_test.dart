import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mibook/layers/domain/usecases/get_favorite_list.dart';
import 'package:mibook/layers/domain/usecases/set_favorite.dart';
import 'package:mibook/layers/domain/usecases/watch_favorite.dart';
import 'package:mibook/layers/presentation/screens/favoritelist/favorite_item_ui.dart';
import 'package:mibook/layers/presentation/screens/favoritelist/favorite_list_event.dart';
import 'package:mibook/layers/presentation/screens/favoritelist/favorite_list_state.dart';
import 'package:mibook/layers/presentation/screens/favoritelist/favorite_list_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Assuming these are the domain models - adjust if needed
import 'package:mibook/layers/domain/models/book_list_domain.dart'; // Replace with actual path

@GenerateNiceMocks([
  MockSpec<IGetFavoriteList>(),
  MockSpec<ISetFavorite>(),
  MockSpec<IWatchFavorite>(),
])
import 'favorite_list_view_model_test.mocks.dart';

void main() {
  late MockIGetFavoriteList mockGetFavoriteList;
  late MockISetFavorite mockSetFavorite;
  late MockIWatchFavorite mockWatchFavorite;
  late FavoriteListViewModel sut;

  setUp(() {
    mockGetFavoriteList = MockIGetFavoriteList();
    mockSetFavorite = MockISetFavorite();
    mockWatchFavorite = MockIWatchFavorite();
    sut = FavoriteListViewModel(
      mockGetFavoriteList,
      mockSetFavorite,
      mockWatchFavorite,
    );
  });

  tearDown(() {
    sut.close();
  });

  group('FavoriteListViewModel', () {
    test('initial state is correct', () {
      expect(sut.state, FavoriteListState.initial());
    });

    test(
      'DidAppearEvent starts watching favorites and emits updated state',
      () async {
        // Arrange
        final favoriteDataList = [
          BookDomain(
            id: '1',
            kind: 'book',
            title: 'Book 1',
            authors: ['Author 1'],
            description: 'Desc 1',
            thumbnail: 'thumb1',
          ),
        ];
        final expectedUIList = favoriteDataList
            .map((data) => FavoriteItemUI.fromDomain(data))
            .toList();
        when(
          mockWatchFavorite(),
        ).thenAnswer((_) => Stream.value(favoriteDataList));

        // Act
        sut.add(DidAppearEvent());

        // Assert
        await expectLater(
          sut.stream,
          emits(FavoriteListState.initial().copyWith(books: expectedUIList)),
        );
        verify(mockWatchFavorite()).called(1);
      },
    );

    test('DidAppearEvent handles errors from watch favorite', () async {
      // Arrange
      final error = Exception('Watch error');
      when(mockWatchFavorite()).thenAnswer((_) => Stream.error(error));

      // Act
      sut.add(DidAppearEvent());

      // Assert
      await expectLater(
        sut.stream,
        emits(
          FavoriteListState.initial().copyWith(
            errorMessage: error.toString(),
            isLoading: false,
          ),
        ),
      );
      verify(mockWatchFavorite()).called(1);
    });

    test('DidTapUnfavoriteEvent unfavorites book and reloads list', () async {
      // Arrange
      final bookId = '1';
      final initialBooks = [
        FavoriteItemUI(
          id: '1',
          kind: 'book',
          title: 'Book 1',
          authors: 'Author 1',
          description: 'Desc 1',
          thumbnail: 'thumb1',
        ),
      ];
      final updatedBooks = <FavoriteItemUI>[]; // After unfavoriting
      sut.emit(
        FavoriteListState.initial().copyWith(books: initialBooks),
      ); // Set initial state
      when(mockSetFavorite(any, false)).thenAnswer((_) async {});
      when(
        mockGetFavoriteList(),
      ).thenAnswer((_) async => []); // Empty after unfavorite

      // Act
      sut.add(DidTapUnfavoriteEvent(bookId));

      // Assert
      await expectLater(
        sut.stream,
        emits(FavoriteListState.initial().copyWith(books: updatedBooks)),
      );
      verify(
        mockSetFavorite(
          argThat(
            isA<BookDomain>().having((item) => item.id, 'id', bookId),
          ),
          false,
        ),
      ).called(1);
    });
  });
}
