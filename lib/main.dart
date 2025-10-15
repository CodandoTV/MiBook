import 'package:flutter/material.dart';
import 'package:mibook/core/routes/app_router.dart';
import 'package:mibook/core/di/di.dart';
import 'package:mibook/layers/data/api/storage_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await getIt.get<IStorageClient>().initLocalDataSource();
  runApp(CoreApplication());
}

class CoreApplication extends StatelessWidget {
  CoreApplication({super.key});

  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      title: 'Mibook',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          surface: Colors.white,
        ),
      ),
    );
  }
}
