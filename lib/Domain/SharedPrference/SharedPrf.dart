
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPrf{
  FlutterSecureStorage storage= FlutterSecureStorage();
  save(String key , String value)async{
    await storage.write(key: key, value: value);
  }
  Future<String?> get(String key)async{
    return await storage.read(key: key);
  }
  Future<void> delete(String key)async{
    await storage.delete(key: key);
  }
  Future<void> saveThemeMode(String mode) async {
    await save("theme_mode", mode);
  }
  Future<String> getThemeMode() async {
    return await get("theme_mode") ?? "dark";
  }
}