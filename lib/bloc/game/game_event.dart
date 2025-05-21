import 'package:equatable/equatable.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
  
  @override
  List<Object?> get props => [];
}

class ScorePoint extends GameEvent {
  final int points;
  
  const ScorePoint({this.points = 10});
  
  @override
  List<Object?> get props => [points];
}

class ResetGame extends GameEvent {
  const ResetGame();
}

class PauseGame extends GameEvent {
  const PauseGame();
}

class ResumeGame extends GameEvent {
  const ResumeGame();
}

class GameOver extends GameEvent {
  const GameOver();
}