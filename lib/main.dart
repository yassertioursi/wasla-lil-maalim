import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() {
  runApp(const WslaApp());
}

class WslaApp extends StatelessWidget {
  const WslaApp({super.key});

  static const Color background = Color(0xFF1A1A2E);
  static const Color accent = Color(0xFFF5C518);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'وصلة للمعالم',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: accent,
          brightness: Brightness.dark,
          primary: accent,
        ),
        textTheme: const TextTheme(
          displayMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}