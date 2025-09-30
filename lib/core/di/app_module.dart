import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @lazySingleton
  EncryptedSharedPreferences get encryptedSharedPreferences =>
      EncryptedSharedPreferences();
}
