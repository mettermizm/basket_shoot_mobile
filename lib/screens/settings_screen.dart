// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../services/storage_service.dart';
import '../widgets/custom_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.blue.shade900,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Audio',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return SwitchListTile(
                  title: const Text(
                    'Sound Effects',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: state.isSoundEnabled,
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(SetSound(value));
                  },
                  activeColor: Colors.green,
                  tileColor: Colors.blue.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            const Text(
              'Game Data',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text(
                'Reset High Score',
                style: TextStyle(color: Colors.white),
              ),
              trailing: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Reset High Score'),
                    content: const Text(
                      'Are you sure you want to reset your high score? This action cannot be undone.'
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('CANCEL'),
                      ),
                      TextButton(
                        onPressed: () {
                          StorageService.resetHighScore();
                          context.read<GameBloc>().add(const ResetGame());
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('High score has been reset'),
                            ),
                          );
                        },
                        child: const Text(
                          'RESET',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
              tileColor: Colors.blue.shade800,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return ListTile(
                  title: const Text(
                    'Difficulty Level',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "_getDifficultyText(state.difficultyLevel)",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: DropdownButton<int>(
                    //value: state.difficultyLevel,
                    dropdownColor: Colors.blue.shade700,
                    iconEnabledColor: Colors.white,
                    underline: Container(),
                    items: [
                      DropdownMenuItem(
                        value: 1,
                        child: const Text('Easy', style: TextStyle(color: Colors.white)),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: const Text('Medium', style: TextStyle(color: Colors.white)),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: const Text('Hard', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        //context.read<SettingsBloc>().add(SetDifficulty(value));
                      }
                    },
                  ),
                  tileColor: Colors.blue.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
            ),
            const Spacer(),
            CustomButton(
              text: 'BACK TO MENU',
              onPressed: () => Navigator.of(context).pop(),
              color: Colors.blue,
              width: double.infinity,
              height: 50,
            ),
            const SizedBox(height: 10),
            CustomButton(
              text: 'ABOUT',
              onPressed: () => _showAboutDialog(context),
              color: Colors.blue.shade600,
              width: double.infinity,
              height: 50,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  String _getDifficultyText(int level) {
    switch (level) {
      case 1:
        return 'Slower game speed for beginners';
      case 2:
        return 'Moderate game speed';
      case 3:
        return 'Fast game speed for experts';
      default:
        return 'Select difficulty level';
    }
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About This Game'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Version: 1.0.0'),
            SizedBox(height: 10),
            Text('Developed by: Your Name'),
            SizedBox(height: 10),
            Text('This game was created using Flutter and follows the BLoC pattern for state management.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('CLOSE'),
          ),
        ],
      ),
    );
  }
}