import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String name;
  final ValueNotifier<num> _score;
  final ValueNotifier<num?> _guess;

  User({
    required this.id,
    required this.name,
  })  : _score = ValueNotifier(0),
        _guess = ValueNotifier(null);

  num getScore() => _score.value;

  num? getGuess() => _guess.value;

  void awardPoints(num points) {
    this._score.value += points;
  }

  void makeGuess(num price) {
    this._guess.value = price;
  }

  void clearGuess() {
    this._guess.value = null;
  }
}
