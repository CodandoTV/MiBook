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

  setUp() {
    storageClient = MockIStorageClient();
    sut = ReadingDataSource(storageClient);
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
  });
}
