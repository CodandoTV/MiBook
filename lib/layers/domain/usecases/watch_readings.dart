import 'package:injectable/injectable.dart';
import 'package:mibook/layers/domain/models/reading_domain.dart';
import 'package:mibook/layers/domain/repository/reading_repository.dart';

abstract class IWatchReadings {
  Stream<List<ReadingDomain>> call();
}

@Injectable(as: IWatchReadings)
class WatchReadings implements IWatchReadings {
  final IReadingRepository _readingRepository;

  WatchReadings(this._readingRepository);

  @override
  Stream<List<ReadingDomain>> call() => _readingRepository.watchReadings();
}
