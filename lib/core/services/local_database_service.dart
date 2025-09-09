import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabaseService {
  // ArticleModel -> toMap -> json.encode -> String
  Future<void> setString(String key, String value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }

  // ArticleModel -> toMap -> json.encode -> List<String>
  Future<void> setStringList(String key, List<String> value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setStringList(key, value);
  }

  // String -> json.decode -> fromMap -> ArticleModel
  Future<String?> getString(String key) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  // List<String> -> json.decode -> fromMap -> ArticleModel
  Future<List<String>?> getStringList(String key) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(key);
  }
}
