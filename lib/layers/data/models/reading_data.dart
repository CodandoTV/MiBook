import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mibook/layers/domain/models/reading_domain.dart';
part 'reading_data.g.dart';

@JsonSerializable()
class ReadingData {
  final String bookId;
  final double progress;

  ReadingData({
    required this.bookId,
    required this.progress,
  });

  factory ReadingData.fromJson(Map<String, dynamic> json) =>
      _$ReadingDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReadingDataToJson(this);

  factory ReadingData.fromDomain(ReadingDomain domain) => ReadingData(
    bookId: domain.bookId,
    progress: domain.progress,
  );

  ReadingDomain toDomain() => ReadingDomain(
    bookId: bookId,
    progress: progress,
  );
}
