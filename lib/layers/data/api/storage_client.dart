import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mibook/layers/data/api/custom_errors.dart';
import 'package:mibook/layers/data/models/reading_data.dart';
import 'package:mibook/layers/data/models/reading_list_data.dart';

const _readingListInfo = 'ReadingList';

abstract class IStorageClient {
  List<ReadingData> getReadingList();
  Future<void> saveReading(ReadingData reading);
  Future get(String key);
  Future<void> clearDB();
}

@LazySingleton(as: IStorageClient)
class StorageClient implements IStorageClient {
  final Box appBox;

  StorageClient(this.appBox);

  @override
  List<ReadingData> getReadingList() {
    ReadingListData readingListData = appBox.get(
      _readingListInfo,
      defaultValue: ReadingListData([]),
    );

    return readingListData.list;
  }

  @override
  Future<void> saveReading(ReadingData reading) {
    var hiveList = getReadingList();
    if (hiveList.any((element) => element.bookId == reading.bookId)) {
      throw DuplicatedReadingError();
    }
    hiveList.add(reading);
    final readingListData = ReadingListData(hiveList);
    return appBox.put(_readingListInfo, readingListData);
  }

  @override
  Future<void> clearDB() => appBox.clear();

  @override
  Future get(String key) => appBox.get(key);
}
