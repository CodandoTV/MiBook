import 'package:mibook/layers/domain/models/reading_domain.dart';

abstract class IReadingRepository {
  Future<void> startReading({
    required ReadingDomain reading,
  });
  List<ReadingDomain> getReadings();
}
