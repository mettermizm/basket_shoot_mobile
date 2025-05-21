import 'package:flame_audio/flame_audio.dart';

class AudioService {
  static bool _isMuted = false;

  static Future<void> initialize() async {
    await FlameAudio.audioCache.loadAll([
      /*'launch.wav',
      'score.wav',
      'miss.wav',
      */
    ]);
  }

  static void playSound(String sound) {
    if (!_isMuted) {
      FlameAudio.play(sound);
    }
  }

  static void setMuted(bool muted) {
    _isMuted = muted;
  }
}