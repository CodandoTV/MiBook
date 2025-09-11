import 'package:mibook/layers/data/datasource/reading_data_source.dart';
import 'package:mibook/layers/data/models/reading_data.dart';
import 'package:mibook/layers/domain/repository/reading_repository.dart';

class ReadingRepository implements IReadingRepository {
  final IReadingDataSource _dataSource;

  ReadingRepository(this._dataSource);

  @override
  Future<void> startReading({
    required String bookId,
    required double progress,
  }) async {
    final readingData = ReadingData(
      bookId: bookId,
      progress: progress,
    );
    await _dataSource.startReading(readingData: readingData);
  }
}
