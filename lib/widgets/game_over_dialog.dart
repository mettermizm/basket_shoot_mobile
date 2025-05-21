import 'package:basket_shoot_mobile/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class GameOverDialog extends StatelessWidget {
  final int score;
  final int highScore;
  final VoidCallback onRestart;

  const GameOverDialog({
    super.key,
    required this.score,
    required this.highScore,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    final isNewHighScore = score >= highScore;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blue.shade800,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'GAME OVER',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Score: $score',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'High Score: $highScore',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            if (isNewHighScore)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'NEW HIGH SCORE!',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 30),
            CustomButton(
              text: 'PLAY AGAIN',
              onPressed: onRestart,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}