import 'dart:convert';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:injectable/injectable.dart';
import 'package:mibook/layers/data/models/reading_data.dart';

const _readingListKey = 'reading_list';

abstract class IReadingDataSource {
  Future<void> startReading({
    required ReadingData readingData,
  });
  Future<List<ReadingData>> getReadingData();
}

@Injectable(as: IReadingDataSource)
class ReadingDataSource implements IReadingDataSource {
  final _storage = EncryptedSharedPreferences();

  @override
  Future<void> startReading({
    required ReadingData readingData,
  }) async {
    final readingList = await _storage.getString(_readingListKey);
    if (readingList.isEmpty) {
      final string = jsonEncode([readingData.toJson()]);
      await _storage.setString(_readingListKey, string);
    } else {
      final json = jsonDecode(readingList) as List;
      final list = json
          .map((e) => ReadingData.fromJson(e as Map<String, dynamic>))
          .toList();
      final index = list.indexWhere(
        (element) => element.bookId == readingData.bookId,
      );
      if (index != -1) {
        list[index] = readingData;
      } else {
        list.add(readingData);
      }
      final string = jsonEncode(list.map((e) => e.toJson()).toList());
      await _storage.setString(_readingListKey, string);
    }
    final json = readingData.toJson();
    await _storage.setString(readingData.bookId, json.toString());
  }

  @override
  Future<List<ReadingData>> getReadingData() async {
    final readingList = await _storage.getString(_readingListKey);
    if (readingList.isEmpty) {
      return [];
    }
    final json = jsonDecode(readingList) as List;
    final list = json
        .map((e) => ReadingData.fromJson(e as Map<String, dynamic>))
        .toList();
    return list;
  }
}
