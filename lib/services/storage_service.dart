import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _prefs;
  static const String _highScoreKey = 'high_score';

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<int> getHighScore() async {
    return _prefs.getInt(_highScoreKey) ?? 0;
  }

  static Future<void> saveHighScore(int score) async {
    final currentHighScore = await getHighScore();
    if (score > currentHighScore) {
      await _prefs.setInt(_highScoreKey, score);
    }
  }

  static Future<void> resetHighScore() async {
    await _prefs.remove(_highScoreKey);
  }
}