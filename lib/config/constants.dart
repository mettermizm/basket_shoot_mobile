class GameConstants {
  // Game dimensions
  static const double basketballRadius = 30.0;
  static const double hoopWidth = 100.0;
  static const double hoopHeight = 60.0;
  static const double hoopThickness = 10.0;
  
  // Physics
  static const double gravity = 9.8;
  static const double dragMultiplier = 0.15;
  static const double maxDragDistance = 200.0;
  static const double minVelocity = 100.0;
  static const double maxVelocity = 1000.0;
  
  // Game settings
  static const int pointsPerScore = 10;
  static const double scoringZonePadding = 5.0;
  static const int maxLives = 3;
  
  // Animation durations
  static const Duration scoreAnimationDuration = Duration(milliseconds: 500);
  static const Duration resetAnimationDuration = Duration(milliseconds: 300);
  
  /* Audio file paths
  static const String launchSoundPath = 'launch.wav';
  static const String scoreSoundPath = 'score.wav';
  static const String missSoundPath = 'miss.wav';*/
}