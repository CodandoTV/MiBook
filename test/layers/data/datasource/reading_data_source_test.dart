import 'package:flutter_test/flutter_test.dart';
import 'package:mibook/layers/data/api/storage_client.dart';
import 'package:mibook/layers/data/datasource/reading_data_source.dart';
import 'package:mibook/layers/data/models/reading_data.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<IStorageClient>()])
import 'reading_data_source_test.mocks.dart';

void main() {
  late MockIStorageClient storageClient;
  late ReadingDataSource sut;
  late Stream<List<ReadingData>> mockStream;

  setUp() {
    storageClient = MockIStorageClient();
    sut = ReadingDataSource(storageClient);
    final fakeListData = [
      ReadingData(
        'id',
        'Harry Potter',
        'image',
        0.5,
      ),
    ];
    final Iterable<List<ReadingData>> fakeIterableReadingData = [fakeListData];
    mockStream = Stream.fromIterable(fakeIterableReadingData);
    when(storageClient.watchReadingList()).thenAnswer((_) => mockStream);
  }

  group('ReadingDataSource', () {
    setUp();

    test('startReading', () async {
      final fakeData = ReadingData('id', 'Harry Potter', 'image', 0.5);
      await sut.startReading(readingData: fakeData);
      verify(storageClient.saveReading(fakeData)).called(1);
    });

    test('getReadingList', () async {
      final fakeData = [ReadingData('id', 'Harry Potter', 'image', 0.5)];
      when(storageClient.getReadingList()).thenAnswer((_) async => fakeData);
      final result = await sut.getReadingData();
      verify(storageClient.getReadingList()).called(1);
      expect(result, fakeData);
    });

    test('should return the stream from storage client', () async {
      // Act
      final result = sut.watchReadingData();

      // Assert
      expect(result, equals(mockStream));
      verify(storageClient.watchReadingList()).called(1);
      verifyNoMoreInteractions(storageClient);
    });

    test('should emit the same values as the storage client stream', () async {
      // Arrange
      final emittedValues = <List<ReadingData>>[];

      // Act
      final subscription = sut.watchReadingData().listen(
        (data) => emittedValues.add(data),
      );

      // // Wait for stream to complete
      await Future.delayed(Duration.zero);
      await subscription.cancel();

      // Assert
      expect(emittedValues.length, equals(1));
      expect(emittedValues[0].first.bookId, equals('id'));
      verify(storageClient.watchReadingList()).called(1);
    });
  });
}
