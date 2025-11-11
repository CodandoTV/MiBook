import 'package:injectable/injectable.dart';
import 'package:mibook/layers/data/datasource/reading_data_source.dart';
import 'package:mibook/layers/data/models/reading_data.dart';
import 'package:mibook/layers/domain/models/reading_domain.dart';
import 'package:mibook/layers/domain/repository/reading_repository.dart';

@Singleton(as: IReadingRepository)
class ReadingRepository implements IReadingRepository {
  final IReadingDataSource _dataSource;

  ReadingRepository(this._dataSource);

  @override
  Future<void> startReading({
    required ReadingDomain reading,
  }) async {
    final data = ReadingData(
      reading.bookId,
      reading.bookName,
      reading.bookThumb,
      reading.progress,
    );
    await _dataSource.startReading(readingData: data);
  }

  @override
  Future<List<ReadingDomain>> getReadings() async {
    final data = await _dataSource.getReadingData();
    return data.map((e) => e.toDomainModel()).toList();
  }
}
