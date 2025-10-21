import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mibook/layers/data/models/reading_data.dart';

const _readingListInfo = 'ReadingList';

abstract class IStorageClient {
  Future initLocalDataSource();
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
  Future initLocalDataSource() async {
    print('Init Datasource');
    await Hive.initFlutter();
    Hive.registerAdapter(ReadingDataAdapter());
  }

  @override
  List<ReadingData> getReadingList() =>
      appBox.get(_readingListInfo, defaultValue: []);

  @override
  Future<void> saveReading(ReadingData reading) {
    var hiveList = getReadingList();
    hiveList.add(reading);

    print('Reading saved: ${reading.bookName}');
    return appBox.put(_readingListInfo, hiveList);
  }

  @override
  Future<void> clearDB() => appBox.clear();

  @override
  Future get(String key) => appBox.get(key);
}
