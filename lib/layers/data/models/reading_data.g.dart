// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadingData _$ReadingDataFromJson(Map<String, dynamic> json) => ReadingData(
  bookId: json['bookId'] as String,
  progress: (json['progress'] as num).toDouble(),
);

Map<String, dynamic> _$ReadingDataToJson(ReadingData instance) =>
    <String, dynamic>{'bookId': instance.bookId, 'progress': instance.progress};
