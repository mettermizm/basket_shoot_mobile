import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'config/theme.dart';
import 'screens/home_screen.dart';

class BasketballShotApp extends StatelessWidget {
  const BasketballShotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basketball Shot Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        textTheme: GoogleFonts.pressStart2pTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}