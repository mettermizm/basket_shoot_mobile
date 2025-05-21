// lib/game/basketball_game.dart
import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';

import '../bloc/game/game_bloc.dart';
import '../bloc/game/game_event.dart';
import '../bloc/game/game_state.dart';
import '../config/constants.dart';
import '../services/audio_service.dart';
import 'components/basketball.dart';
import 'components/hoop.dart';
import 'components/score_text.dart';

class BasketballGame extends FlameGame with HasCollisionDetection, DragCallbacks {
  late final Basketball basketball;
  late final Hoop hoop;
  late final ScoreText scoreText;
  final GameBloc gameBloc;
  
  BasketballGame({required this.gameBloc});
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(FlameBlocProvider<GameBloc, GameState>.value(
      value: gameBloc,
      children: [], // çocuklar bu contextteki diğer Flame bileşenleriyle paylaşılabilir
    ));

    hoop = Hoop();
    basketball = Basketball();
    scoreText = ScoreText();

    await addAll([hoop, basketball, scoreText]);

    resetGame();
  }
  
  void resetGame() {
    basketball.reset();
    gameBloc.add(const ResetGame()); // Doğrudan gameBloc'u kullan
  }

  void handleScore() {
    //AudioService.playSound(GameConstants.scoreSoundPath);
    gameBloc.add(const ScorePoint());
  }

  
  void handleMiss() {
    //AudioService.playSound(GameConstants.missSoundPath);
    resetGame();
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    // Check if ball went off-screen
    if (basketball.position.y > size.y + basketball.size.y) {
      handleMiss();
    }
    
    // Check scoring condition if ball is in motion
    if (basketball.isInMotion && basketball.hasContactWithHoop(hoop)) {
      if (!basketball.hasScored) {
        basketball.hasScored = true;
        handleScore();
      }
    }
  }
  
  @override
  Color backgroundColor() => const Color(0xFFB1E6FF);
}