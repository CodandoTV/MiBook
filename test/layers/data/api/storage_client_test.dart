import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mibook/layers/data/api/custom_errors.dart';
import 'package:mibook/layers/data/api/storage_client.dart';
import 'package:mibook/layers/data/models/reading_data.dart';
import 'package:mibook/layers/data/models/reading_list_data.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<Box>()])
import 'storage_client_test.mocks.dart';

void main() {
  late MockBox appBox;
  late StorageClient sut;

  setUp() {
    appBox = MockBox();
    sut = StorageClient(appBox);
  }

  group('StorageClient', () {
    setUp();

    test(
      'given box returns reading list, when getReadingList, should return list',
      () {
        when(
          appBox.get('ReadingList', defaultValue: anyNamed('defaultValue')),
        ).thenReturn(
          ReadingListData(
            [
              ReadingData('bookId', 'bookName', 'bookThumb', 0.5),
            ],
          ),
        );

        final result = sut.getReadingList();

        verify(
          appBox.get('ReadingList', defaultValue: anyNamed('defaultValue')),
        ).called(1);

        expect(
          result,
          [
            ReadingData('bookId', 'bookName', 'bookThumb', 0.5),
          ],
        );
      },
    );

    test(
      'given appBox contains reading, when saveReading, should throw duplicated reading error',
      () async {
        when(
          appBox.get(any, defaultValue: anyNamed('defaultValue')),
        ).thenReturn(
          ReadingListData([
            ReadingData('bookId', 'bookName', 'bookThumb', 0.5),
          ]),
        );

        expectLater(
          () => sut.saveReading(
            ReadingData('bookId', 'bookName', 'bookThumb', 0.5),
          ),
          throwsA(isA<DuplicatedReadingError>()),
        );
      },
    );

    test(
      'given appBox does not contain reading, when saveReading, should save reading',
      () async {
        when(
          appBox.get(any, defaultValue: anyNamed('defaultValue')),
        ).thenReturn(
          ReadingListData([]),
        );

        await sut.saveReading(
          ReadingData('bookId', 'bookName', 'bookThumb', 0.5),
        );

        verify(
          appBox.put(
            'ReadingList',
            ReadingListData([
              ReadingData('bookId', 'bookName', 'bookThumb', 0.5),
            ]),
          ),
        ).called(1);
      },
    );

    test('clearDB', () async {
      await sut.clearDB();

      verify(appBox.clear()).called(1);
    });
  });
}
