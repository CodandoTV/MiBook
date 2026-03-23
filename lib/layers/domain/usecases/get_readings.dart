import 'package:injectable/injectable.dart';
import 'package:mibook/layers/domain/models/reading_domain.dart';
import 'package:mibook/layers/domain/repository/reading_repository.dart';

abstract class IGetReadings {
  Future<List<ReadingDomain>> call();
}

@Injectable(as: IGetReadings)
class GetReadings implements IGetReadings {
  final IReadingRepository _readingRepository;

  GetReadings(this._readingRepository);

  @override
  Future<List<ReadingDomain>> call() async =>
      await _readingRepository.getReadings();
}
