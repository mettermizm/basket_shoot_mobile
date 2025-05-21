// lib/game/components/game_overlay.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/game/game_bloc.dart';
import '../../bloc/game/game_event.dart';
import '../../bloc/game/game_state.dart';
import '../../bloc/settings/settings_bloc.dart';
import '../../bloc/settings/settings_event.dart';
import '../../bloc/settings/settings_state.dart';
import '../../widgets/game_over_dialog.dart';

class GameOverlay extends StatelessWidget {
  const GameOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Settings button (top right)
        Positioned(
          top: 20,
          right: 20,
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  state.isSoundEnabled ? Icons.volume_up : Icons.volume_off,
                  color: Colors.white,
                  shadows: const [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                onPressed: () {
                  context.read<SettingsBloc>().add(ToggleSound());
                },
              );
            },
          ),
        ),
        
        // Game over dialog listener
        BlocListener<GameBloc, GameState>(
          listenWhen: (previous, current) => 
              previous.gameStatus != GameStatus.gameOver && 
              current.gameStatus == GameStatus.gameOver,
          listener: (context, state) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => GameOverDialog(
                score: state.score,
                highScore: state.highScore,
                onRestart: () {
                  context.read<GameBloc>().add(const ResetGame());
                  Navigator.of(context).pop();
                },
              ),
            );
          },
          child: const SizedBox(),
        ),
        
        // Pause button
        Positioned(
          top: 20,
          right: 80,
          child: BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  state.gameStatus == GameStatus.paused ? Icons.play_arrow : Icons.pause,
                  color: Colors.white,
                  shadows: const [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                onPressed: () {
                  context.read<GameBloc>().add(
                    state.gameStatus == GameStatus.paused
                        ? const ResumeGame()
                        : const PauseGame(),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}