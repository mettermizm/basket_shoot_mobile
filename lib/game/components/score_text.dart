// lib/game/components/score_text.dart
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';

import '../../bloc/game/game_bloc.dart';
import '../../bloc/game/game_state.dart';

class ScoreText extends PositionComponent with FlameBlocReader<GameBloc, GameState> {
  late TextComponent _scoreTextComponent;
  late TextComponent _highScoreTextComponent;
  
  @override
  Future<void> onLoad() async {
    _scoreTextComponent = TextComponent(
      text: 'Score: 0',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              blurRadius: 4,
              color: Colors.black,
              offset: Offset(2, 2),
            ),
          ],
        ),
      ),
    );
    
    _highScoreTextComponent = TextComponent(
      text: 'High Score: 0',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              blurRadius: 4,
              color: Colors.black,
              offset: Offset(1, 1),
            ),
          ],
        ),
      ),
    );
    
    add(_scoreTextComponent);
    add(_highScoreTextComponent);
  }
  
  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    
    // Position the score text at the top left corner
    _scoreTextComponent.position = Vector2(20, 20);
    
    // Position the high score text below the score text
    _highScoreTextComponent.position = Vector2(20, 50);
  }
  
  @override
  void onNewState(GameState state) {
    _scoreTextComponent.text = 'Score: ${state.score}';
    _highScoreTextComponent.text = 'High Score: ${state.highScore}';
  }
}