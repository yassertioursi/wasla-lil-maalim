import 'dart:math';

import 'package:flutter/material.dart';

import 'main.dart';
import 'result_screen.dart';

class Landmark {
  final String arabicName;
  final String imageUrl;
  final String englishName;

  const Landmark({
    required this.arabicName,
    required this.imageUrl,
    required this.englishName,
  });
}

class GameData {
  static const List<Landmark> landmarks = [
    Landmark(
      arabicName: 'برج إيفل',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/'
          'Tour_Eiffel_Wikimedia_Commons.jpg/500px-Tour_Eiffel_Wikimedia_Commons.jpg',
      englishName: 'Eiffel Tower',
    ),
    Landmark(
      arabicName: 'برج خليفة',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/'
          'Burj_Khalifa_%28worlds_tallest_building%29_and_the_Dubai_skyline_%2825781049892%29.jpg/'
          '500px-Burj_Khalifa_%28worlds_tallest_building%29_and_the_Dubai_skyline_%2825781049892%29.jpg',
      englishName: 'Burj Khalifa',
    ),
    Landmark(
      arabicName: 'الكولوسيوم',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/de/'
          'Colosseo_2020.jpg/500px-Colosseo_2020.jpg',
      englishName: 'Colosseum',
    ),
    Landmark(
      arabicName: 'سور الصين العظيم',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/'
          'The_Great_Wall_of_China_at_Jinshanling-edit.jpg/500px-The_Great_Wall_of_China_at_Jinshanling-edit.jpg',
      englishName: 'Great Wall of China',
    ),
    Landmark(
      arabicName: 'ماتشو بيتشو',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bb/'
          'Machu_Picchu%2C_2023_%28012%29.jpg/500px-Machu_Picchu%2C_2023_%28012%29.jpg',
      englishName: 'Machu Picchu',
    ),
    Landmark(
      arabicName: 'البتراء',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/'
          'Al_Deir_Petra.JPG/500px-Al_Deir_Petra.JPG',
      englishName: 'Petra',
    ),
    Landmark(
      arabicName: 'ساغرادا فاميليا',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ef/'
          'SF_maig_2_cropped.jpg/500px-SF_maig_2_cropped.jpg',
      englishName: 'Sagrada Familia',
    ),
    Landmark(
      arabicName: 'تاج محل',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/'
          'Taj_Mahal_%28Edited%29.jpeg/500px-Taj_Mahal_%28Edited%29.jpeg',
      englishName: 'Taj Mahal',
    ),
    Landmark(
      arabicName: 'ساعة بيغ بن',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/43/'
          'Elizabeth_Tower%2C_June_2022.jpg/500px-Elizabeth_Tower%2C_June_2022.jpg',
      englishName: 'Big Ben',
    ),
    Landmark(
      arabicName: 'أهرامات الجيزة',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/'
          'Pyramids_of_the_Giza_Necropolis.jpg/500px-Pyramids_of_the_Giza_Necropolis.jpg',
      englishName: 'Pyramids of Giza',
    ),
  ];
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final Random _random = Random();
  static const int totalQuestions = 10;

  late List<Landmark> _questions;
  late List<String> _options;
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedIndex;
  bool _answered = false;

  @override
  void initState() {
    super.initState();
    _questions = List<Landmark>.of(GameData.landmarks)..shuffle(_random);
    _buildOptions();
  }

  void _buildOptions() {
    final correct = _questions[_currentIndex].arabicName;
    final others = GameData.landmarks
        .map((l) => l.arabicName)
        .where((n) => n != correct)
        .toList()
      ..shuffle(_random);
    _options = [correct, others[0], others[1], others[2]]..shuffle(_random);
  }

  void _onAnswer(int index) {
    if (_answered) return;
    setState(() {
      _answered = true;
      _selectedIndex = index;
      if (_options[index] == _questions[_currentIndex].arabicName) {
        _score++;
      }
    });

    Future.delayed(const Duration(milliseconds: 800), _nextQuestion);
  }

  void _nextQuestion() {
    if (!mounted) return;
    if (_currentIndex + 1 >= totalQuestions) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(score: _score, total: totalQuestions),
        ),
      );
      return;
    }
    setState(() {
      _currentIndex++;
      _selectedIndex = null;
      _answered = false;
      _buildOptions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final landmark = _questions[_currentIndex];
    final correctAnswer = landmark.arabicName;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: WslaApp.background,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'السؤال ${_currentIndex + 1} / $totalQuestions',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 16),
              child: Center(
                child: Row(
                  children: [
                    const Icon(Icons.star, color: WslaApp.accent, size: 22),
                    const SizedBox(width: 6),
                    Text(
                      '$_score',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: WslaApp.accent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 16 / 10,
                  child: Image.network(
                    landmark.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        color: Colors.white10,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          color: WslaApp.accent,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stack) {
                      return Container(
                        color: Colors.white10,
                        alignment: Alignment.center,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.broken_image, color: Colors.white54, size: 48),
                            SizedBox(height: 8),
                            Text('تعذر تحميل الصورة',
                                style: TextStyle(color: Colors.white54)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                color: Colors.white.withValues(alpha: 0.06),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'ما اسم هذا المعلم؟',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.1,
                children: List.generate(_options.length, (i) {
                  return _buildAnswerButton(i, correctAnswer);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerButton(int index, String correctAnswer) {
    final isCorrect = _options[index] == correctAnswer;
    final isSelected = _selectedIndex == index;

    Color background = const Color(0xFF2A2A45);
    if (_answered) {
      if (isCorrect) {
        background = Colors.green.shade700;
      } else if (isSelected) {
        background = Colors.red.shade700;
      }
    }

    return ElevatedButton(
      onPressed: () => _onAnswer(index),
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        disabledBackgroundColor: background,
      ),
      child: Text(
        _options[index],
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
  }
}