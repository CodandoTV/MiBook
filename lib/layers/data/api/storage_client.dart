import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mibook/core/di/box_builder.dart';
import 'package:mibook/layers/data/models/reading_data.dart';

const _appBoxName = 'AppBox';
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
  final BoxBuilder _boxBuilder;
  late Box _appBox;

  StorageClient(this._boxBuilder) {
    _boxBuilder.appBox.then((value) => _appBox = value);
  }

  @override
  Future initLocalDataSource() async {
    print('Init Datasource');
    await Hive.initFlutter();
    Hive.registerAdapter(ReadingDataAdapter());
  }

  @override
  List<ReadingData> getReadingList() =>
      _appBox.get(_readingListInfo, defaultValue: []);

  @override
  Future<void> saveReading(ReadingData reading) {
    var hiveList = getReadingList();
    hiveList.add(reading);

    print('Reading saved: ${reading.bookName}');
    return _appBox.put(_readingListInfo, hiveList);
  }

  @override
  Future<void> clearDB() => _appBox.clear();

  @override
  Future get(String key) => _appBox.get(key);
}
