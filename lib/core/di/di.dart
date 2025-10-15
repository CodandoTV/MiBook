import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  getIt.init(environment: 'prod');

  final appBox = await Hive.openBox('AppBox');
  getIt.registerSingleton<Box>(appBox);
}
