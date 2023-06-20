import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:would_you_buy_it/services/WouldYouBuyItService.dart';
import 'package:would_you_buy_it/widgets/description.dart';
import 'package:would_you_buy_it/widgets/imagePanel.dart';

import '../models/estate.dart';
import '../models/player.dart';
import '../widgets/design/loader.dart';
import '../widgets/design/pageLayout.dart';
import '../widgets/guessWidget.dart';

class GameState {
  GameState({
    Estate? estate,
  }) : _estate = ValueNotifier(estate) {
    asyncInit();
  }

  final ValueNotifier<Estate?> _estate;
  late final List<Player> players;
  late final int rounds;
  late Player activePlayer;

  Future<void> asyncInit() async {
    _estate.value = await fetchEstate();
  }

  ValueListenable<Estate?> get estate => _estate;

  void makeGuess(double price, double guess) {
    activePlayer.makeGuess(price, guess);
    _setNextPlayerActive();
  }

  void _setNextPlayerActive() {
    final activeIndex = players.indexOf(activePlayer);
    activePlayer = players[activeIndex + 1 % players.length];
  }
}

class GamePage extends StatelessWidget {
  const GamePage({
    super.key,
    required this.state,
  });

  final GameState state;

  @override
  Widget build(BuildContext context) => PageLayout(
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: state.estate,
            builder: (context, value, child) => value != null
                ? OrientationBuilder(
                    builder: (context, orientation) =>
                        orientation == Orientation.landscape
                            ? _LandscapeView(
                                estate: value,
                                onGuessed: state.makeGuess,
                              )
                            : _PortraitView(
                                estate: value,
                                onGuessed: state.makeGuess,
                              ),
                  )
                : Loader(),
          ),
        ),
      );
}

class _LandscapeView extends StatelessWidget {
  const _LandscapeView({
    required this.estate,
    this.onGuessed,
  });

  final Estate estate;
  final void Function(double, double)? onGuessed;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Column(
            children: [
              Guess(onPressed: (guess) => onGuessed?.call(estate.price, guess)),
              Spacer(),
              DescriptionBox(house: estate),
              Spacer(),
            ],
          ),
          Spacer(),
          Column(
            children: [
              Spacer(),
              ImagePanel(
                images: estate.imageData,
                height: MediaQuery.of(context).size.height * 0.741,
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              Spacer(),
            ],
          ),
        ],
      );
}

class _PortraitView extends StatelessWidget {
  const _PortraitView({
    required this.estate,
    this.onGuessed,
  });

  final Estate estate;
  final void Function(double, double)? onGuessed;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Column(
        children: [
          Spacer(),
          ImagePanel(
            images: estate.imageData,
            height: MediaQuery.of(context).size.height * 0.33,
            width: MediaQuery.of(context).size.width * 0.9,
          ),
          Spacer(),
          Guess(onPressed: (guess) => onGuessed?.call(estate.price, guess)),
          Spacer(),
          DescriptionBox(house: estate),
          Spacer(),
        ],
      )
    ],
  );
}
