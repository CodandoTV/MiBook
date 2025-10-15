import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mibook/layers/domain/models/reading_domain.dart';
part 'reading_data.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class ReadingData extends HiveObject {
  @HiveField(0)
  String bookId;
  @HiveField(1)
  String bookName;
  @HiveField(2)
  String? bookThumb;
  @HiveField(3)
  double progress;

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
}
