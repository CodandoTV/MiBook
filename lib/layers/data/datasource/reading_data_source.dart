import 'package:injectable/injectable.dart';
import 'package:mibook/layers/data/models/reading_data.dart';

abstract class IReadingDataSource {
  Future<void> startReading({
    required ReadingData readingData,
  });
  Future<List<ReadingData>> getReadingData();
}

@Injectable(as: IReadingDataSource)
class ReadingDataSource implements IReadingDataSource {
  @override
  Future<void> startReading({
    required ReadingData readingData,
  }) async {
    // TO DO
  }

  @override
  Future<List<ReadingData>> getReadingData() async => [];
}
