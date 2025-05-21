// lib/screens/home_screen.dart
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../widgets/custom_button.dart';
import 'game_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlameSplashScreen(
      controller: FlameSplashController(
        waitDuration: const Duration(seconds: 1),
        fadeInDuration: const Duration(milliseconds: 500),
        fadeOutDuration: const Duration(milliseconds: 500),
      ),
      showBefore: (BuildContext context) {
        return Container(
          color: Colors.blue.shade900,
        );
      },
      onFinish: (BuildContext context) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeContent()),
        );
      },
      theme: FlameSplashTheme(
        backgroundDecoration: BoxDecoration(
          color: Colors.blue.shade900,
        ),
        logoBuilder: (BuildContext context) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.sports_basketball,
                size: 80,
                color: Colors.orange,
              ),
              const SizedBox(height: 20),
              Text(
                'BASKETBALL SHOT',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.sports_basketball,
                  size: 100,
                  color: Colors.orange,
                ),
                const SizedBox(height: 30),
                Text(
                  'BASKETBALL SHOT',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade300,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                FutureBuilder<int>(
                  future: StorageService.getHighScore(),
                  builder: (context, snapshot) {
                    final highScore = snapshot.data ?? 0;
                    return Text(
                      'HIGH SCORE: $highScore',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 50),
                CustomButton(
                  text: 'PLAY',
                  onPressed: () {
                    debugPrint("Play button pressed");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const GameScreen(),
                      ),
                    );
                  },
                  color: Colors.green,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'SETTINGS',
                  onPressed: () {
                    debugPrint("Settings button pressed");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}