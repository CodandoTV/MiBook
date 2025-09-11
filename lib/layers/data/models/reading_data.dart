import 'package:freezed_annotation/freezed_annotation.dart';
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
}
