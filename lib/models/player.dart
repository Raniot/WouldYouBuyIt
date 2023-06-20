import 'dart:math';

import 'package:flutter/widgets.dart';

class Player {
  Player({
    required this.id, 
    required this.name, 
  }): score = ValueNotifier(Score());
  
  final String id;
  final String name;
  final ValueNotifier<Score> score;

  void makeGuess(double price, double guess) {
    score.value.update(price, guess);
  }
}

class Score {
  Score()
      : guesses = [],
        totalScore = ValueNotifier(0),
        avgScore = ValueNotifier(0);

  final List<double> guesses;

  final ValueNotifier<double> totalScore;
  final ValueNotifier<double> avgScore;

  void update(double price, double guess) {
    guesses.add(guess);

    totalScore.value += min((guess - price).abs() * 10 / price, 10);
    avgScore.value = totalScore.value / guesses.length;
  }
}