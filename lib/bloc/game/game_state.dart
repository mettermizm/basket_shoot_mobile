// lib/bloc/game/game_state.dart
import 'package:equatable/equatable.dart';

enum GameStatus { playing, paused, gameOver }

class GameState extends Equatable {
  final int score;
  final int highScore;
  final GameStatus gameStatus;
  
  const GameState({
    required this.score,
    required this.highScore,
    required this.gameStatus,
  });
  
  factory GameState.initial() => const GameState(
    score: 0,
    highScore: 0,
    gameStatus: GameStatus.playing,
  );
  
  GameState copyWith({
    int? score,
    int? highScore,
    GameStatus? gameStatus,
  }) {
    return GameState(
      score: score ?? this.score,
      highScore: highScore ?? this.highScore,
      gameStatus: gameStatus ?? this.gameStatus,
    );
  }
  
  @override
  List<Object?> get props => [score, highScore, gameStatus];
}