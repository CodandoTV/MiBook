import 'package:injectable/injectable.dart';
import 'package:mibook/layers/domain/models/reading_domain.dart';
import 'package:mibook/layers/domain/repository/reading_repository.dart';

abstract class IStartReading {
  Future<void> call({
    required ReadingDomain reading,
  });
}

@Injectable(as: IStartReading)
class StartReading implements IStartReading {
  final IReadingRepository _repository;

  StartReading(this._repository);

  @override
  Future<void> call({
    required ReadingDomain reading,
  }) async {
    await _repository.startReading(reading: reading);
  }
}
