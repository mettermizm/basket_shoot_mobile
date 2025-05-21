import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../services/storage_service.dart';
import 'game_event.dart';
import 'game_state.dart';

class GameBloc extends HydratedBloc<GameEvent, GameState> {
  GameBloc() : super(GameState.initial()) {
    on<ScorePoint>(_onScorePoint);
    on<ResetGame>(_onResetGame);
    on<PauseGame>(_onPauseGame);
    on<ResumeGame>(_onResumeGame);
    on<GameOver>(_onGameOver);
    
    // Load high score from storage on initialization
    _loadHighScore();
  }
  
  Future<void> _loadHighScore() async {
    final highScore = await StorageService.getHighScore();
    emit(state.copyWith(highScore: highScore));
  }
  
  void _onScorePoint(ScorePoint event, Emitter<GameState> emit) {
    final newScore = state.score + event.points;
    final newHighScore = newScore > state.highScore ? newScore : state.highScore;
    
    emit(state.copyWith(
      score: newScore,
      highScore: newHighScore,
    ));
    
    // Save high score to storage
    StorageService.saveHighScore(newHighScore);
  }
  
  void _onResetGame(ResetGame event, Emitter<GameState> emit) {
    emit(state.copyWith(
      score: 0,
      gameStatus: GameStatus.playing,
    ));
  }
  
  void _onPauseGame(PauseGame event, Emitter<GameState> emit) {
    emit(state.copyWith(
      gameStatus: GameStatus.paused,
    ));
  }
  
  void _onResumeGame(ResumeGame event, Emitter<GameState> emit) {
    emit(state.copyWith(
      gameStatus: GameStatus.playing,
    ));
  }
  
  void _onGameOver(GameOver event, Emitter<GameState> emit) {
    emit(state.copyWith(
      gameStatus: GameStatus.gameOver,
    ));
  }
  
  @override
  GameState? fromJson(Map<String, dynamic> json) {
    return GameState(
      score: json['score'] as int,
      highScore: json['highScore'] as int,
      gameStatus: GameStatus.values[json['gameStatus'] as int],
    );
  }
  
  @override
  Map<String, dynamic>? toJson(GameState state) {
    return {
      'score': state.score,
      'highScore': state.highScore,
      'gameStatus': state.gameStatus.index,
    };
  }
}