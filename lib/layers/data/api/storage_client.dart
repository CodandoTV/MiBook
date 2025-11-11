import 'dart:convert';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:mibook/layers/data/api/custom_errors.dart';
import 'package:mibook/layers/data/models/reading_data.dart';
import 'package:path_provider/path_provider.dart';

abstract class IStorageClient {
  Future<void> saveReading(ReadingData readingData);
  Future<List<ReadingData>> getReadingList();
}

@Singleton(as: IStorageClient)
class StorageClient implements IStorageClient {
  Future<File> _getLocalFile(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$fileName.json');
  }

  @override
  Future<void> saveReading(ReadingData readingData) async {
    final file = await _getLocalFile('reading_list');
    List<ReadingData> currentList = await getReadingList();

    if (currentList.any((item) => item.bookId == readingData.bookId)) {
      throw DuplicatedReadingError();
    }
    currentList.add(readingData);
    final jsonString = jsonEncode(currentList.map((e) => e.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  @override
  Future<List<ReadingData>> getReadingList() async {
    final file = await _getLocalFile('reading_list');

    if (!await file.exists()) {
      return [];
    }

    final jsonString = await file.readAsString();

    if (jsonString.isEmpty) {
      return [];
    }

    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded.map((e) => ReadingData.fromJson(e)).toList();
  }
}
