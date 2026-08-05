import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'main.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const ResultScreen({
    super.key,
    required this.score,
    required this.total,
  });

  String get _message {
    final ratio = score / total;
    if (ratio >= 0.8) return 'ممتاز! معرفة رائعة بالمعالم';
    if (ratio >= 0.5) return 'جيد جداً، واصل التدريب';
    return 'حاول مرة أخرى، ستحصل على نتيجة أفضل';
  }

  IconData get _icon {
    final ratio = score / total;
    if (ratio >= 0.8) return Icons.emoji_events;
    if (ratio >= 0.5) return Icons.thumb_up;
    return Icons.refresh;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: WslaApp.accent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: WslaApp.accent.withValues(alpha: 0.4),
                        blurRadius: 30,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    _icon,
                    size: 64,
                    color: WslaApp.background,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'النتيجة',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  '$score / $total',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 56,
                        color: WslaApp.accent,
                      ),
                ),
                const SizedBox(height: 16),
                Text(
                  _message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 17, color: Colors.white70),
                ),
                const SizedBox(height: 48),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: WslaApp.accent,
                      foregroundColor: WslaApp.background,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('العب مجدداً'),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                        (route) => false,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white54),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('الرئيسية'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}