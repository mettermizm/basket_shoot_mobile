// lib/screens/game_screen.dart
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../game/basketball_game.dart';
import '../game/components/game_overlay.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameBloc = context.read<GameBloc>();
    gameBloc.add(const ResetGame());
    
    return Scaffold(
      body: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          return Stack(
            children: [
              GameWidget(
                game: BasketballGame(gameBloc: gameBloc),
                overlayBuilderMap: {
                  'gameOverlay': (_, game) => const GameOverlay(),
                },
                initialActiveOverlays: const ['gameOverlay'],
                loadingBuilder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
                backgroundBuilder: (context) => Container(
                  color: Colors.blue.shade900,
                ),
              ),
              if (state.gameStatus == GameStatus.paused)
                Container(
                  color: Colors.black54,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade800,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'PAUSED',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}