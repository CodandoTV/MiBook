import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mibook/layers/domain/models/reading_domain.dart';
part 'reading_data.g.dart';

@JsonSerializable()
class ReadingData {
  final String bookId;
  final String bookName;
  final String? bookThumb;
  final double progress;

  ReadingData(
    this.bookId,
    this.bookName,
    this.bookThumb,
    this.progress,
  );

  factory ReadingData.fromJson(Map<String, dynamic> json) =>
      _$ReadingDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReadingDataToJson(this);

  factory ReadingData.fromDomainModel(ReadingDomain domainModel) => ReadingData(
    domainModel.bookId,
    domainModel.bookName,
    domainModel.bookThumb,
    domainModel.progress,
  );

  ReadingDomain toDomainModel() => ReadingDomain(
    bookId: bookId,
    bookName: bookName,
    bookThumb: bookThumb,
    progress: progress,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReadingData &&
          bookId == other.bookId &&
          bookName == other.bookName &&
          bookThumb == other.bookThumb &&
          progress == other.progress;

  @override
  int get hashCode =>
      bookId.hashCode ^
      bookName.hashCode ^
      bookThumb.hashCode ^
      progress.hashCode;
}
