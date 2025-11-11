import 'package:injectable/injectable.dart';
import 'package:mibook/layers/data/api/storage_client.dart';
import 'package:mibook/layers/data/models/reading_data.dart';

abstract class IReadingDataSource {
  Future<void> startReading({
    required ReadingData readingData,
  });
  Future<List<ReadingData>> getReadingData();
}

@Injectable(as: IReadingDataSource)
class ReadingDataSource implements IReadingDataSource {
  final IStorageClient _storageClient;

  ReadingDataSource(this._storageClient);

  @override
  Future<void> startReading({
    required ReadingData readingData,
  }) async => _storageClient.saveReading(readingData);

  @override
  Future<List<ReadingData>> getReadingData() async =>
      await _storageClient.getReadingList();
}
