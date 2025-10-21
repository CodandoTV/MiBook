import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mibook/layers/data/api/storage_client.dart';
import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() async {
  getIt.init(environment: 'prod');

  // final appBox = await Hive.openBox('AppBox');
  // final storageClient = StorageClient(appBox);
  // getIt.registerSingleton<IStorageClient>(storageClient);
}
