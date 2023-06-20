import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:would_you_buy_it/pages/game.dart';
import 'package:would_you_buy_it/pages/game_setup.dart';
import 'package:would_you_buy_it/pages/scoreboard.dart';

import 'pages/home.dart';

void main() {
  runApp(WouldYouBuyIt(state: GameState()));
}

class WouldYouBuyIt extends StatelessWidget {
  WouldYouBuyIt({
    required this.state,
  });

  final GameState state;

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoApp(
        title: 'Would you buy it?',
        initialRoute: '/',
        onGenerateRoute: _RouteGenerator(state).routeGenerate,
      );
    } else {
      return MaterialApp(
        title: 'Would you buy it?',
        initialRoute: '/',
        onGenerateRoute: _RouteGenerator(state).routeGenerate,
      );
    }
  }
}

const String homeRoute = '/';
const String gameSetupRoute = '/game_setup/';
const String gameRoute = '/game/';
const String scoreboardRoute = '/scoreboard/';

class _RouteGenerator {
  _RouteGenerator(this.state);

  final GameState state;

  Route? routeGenerate(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return navigateToRoute(const Home());
      case gameSetupRoute:
        return navigateToRoute(GameSetup(state: state));
      case gameRoute:
        return navigateToRoute(GamePage(state: state));
      case scoreboardRoute:
        return navigateToRoute(Scoreboard(standings: state));
    }

    return null;
  }

  navigateToRoute(Widget page) {
    if (Platform.isIOS) {
      return CupertinoPageRoute(builder: (context) => page);
    } else {
      return MaterialPageRoute(builder: (context) => page);
    }
  }
}
