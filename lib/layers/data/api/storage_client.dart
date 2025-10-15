import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mibook/layers/data/models/reading_data.dart';

const _appBoxName = 'AppBox';
const _readingListInfo = 'ReadingList';

abstract class IStorageClient {
  Future<void> initLocalDataSource();
  List<ReadingData> getReadingList();
  Future<void> saveReading(ReadingData reading);
  Future get(String key);
  Future<void> clearDB();
}

@Injectable(as: IStorageClient)
class StorageClient implements IStorageClient {
  late Box _appBox;

  StorageClient(this._appBox);

  Future<Box> _getAppBox() async => await Hive.openBox(_appBoxName);

  @override
  Future<void> initLocalDataSource() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ReadingDataAdapter());
    _appBox = await _getAppBox();
  }

  @override
  List<ReadingData> getReadingList() =>
      _appBox.get(_readingListInfo, defaultValue: []);

  @override
  Future<void> saveReading(ReadingData reading) {
    var hiveList = getReadingList();
    hiveList.add(reading);

    return _appBox.put(_readingListInfo, hiveList);
  }

  @override
  Future<void> clearDB() => _appBox.clear();

  @override
  Future get(String key) => _appBox.get(key);
}
