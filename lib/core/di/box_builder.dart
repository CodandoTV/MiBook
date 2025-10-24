import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mibook/layers/data/models/reading_data.dart';
import 'package:mibook/layers/data/models/reading_list_data.dart';

@module
abstract class BoxBuilder {
  @preResolve
  Future<Box> get appBox async {
    await Hive.initFlutter();
    Hive.registerAdapter(ReadingDataAdapter());
    Hive.registerAdapter(ReadingListDataAdapter());
    return await Hive.openBox('AppBox');
  }
}
