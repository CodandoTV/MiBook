import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mibook/layers/data/models/reading_data.dart';

part 'reading_list_data.g.dart';

@JsonSerializable()
@freezed
class ReadingListData {
  List<ReadingData> list;

  ReadingListData(this.list);

  factory ReadingListData.fromJson(Map<String, dynamic> json) =>
      _$ReadingListDataFromJson(json);
  Map<String, dynamic> toJson() => _$ReadingListDataToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReadingListData && listEquals(list, other.list);

  @override
  int get hashCode => list.hashCode;
}
