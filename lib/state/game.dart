import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:would_you_buy_it/models/house.dart';

import '../services/WouldYouBuyItService.dart';
import 'user.dart';

class GameState {
  final List<User> users;
  final num roundsToPlay;
  final ValueNotifier<num> _currentRound;
  final ValueNotifier<House?> house;

  GameState({
    required this.users,
    required this.roundsToPlay,
  })  : _currentRound = ValueNotifier(0),
        house = ValueNotifier(null);

  Future<void> startRound() async {
    _currentRound.value++;

    house.value = null;
    try {
      house.value = await fetchHouse();
    } catch (_) {}
  }

  void makeGuess(String userId, num price) {
    final user = users.firstWhere((user) => user.id == userId);
    user.makeGuess(price);

    if (users.every((user) => user.getGuess() != null)) {
      finishRound();
    }
  }

  void assignPoints() {
    for (final user in users) {
      final guess = user.getGuess();
      final score = min(
          ((guess! - house.value!.price).abs() * 10) / house.value!.price, 10);
      user.awardPoints(score);
      user.clearGuess();
    }
  }

  Future<void> finishRound() async {
    assignPoints();
    if (_currentRound.value == roundsToPlay) {
      return finishGame();
    } else {
      return startRound();
    }
  }

  void finishGame() {}
}
