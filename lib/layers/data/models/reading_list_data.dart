import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:mibook/layers/data/models/reading_data.dart';

part 'reading_list_data.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class ReadingListData extends HiveObject {
  @HiveField(0)
  List<ReadingData> list;

  ReadingListData(this.list);

  factory ReadingListData.fromJson(Map<String, dynamic> json) =>
      _$ReadingListDataFromJson(json);
  Map<String, dynamic> toJson() => _$ReadingListDataToJson(this);
}
