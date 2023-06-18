import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:would_you_buy_it/pages/game.dart';

void main() {
  runApp(WouldYouBuyIt());
}

class WouldYouBuyIt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform  == TargetPlatform.iOS) {
      return CupertinoApp(
        title: 'Would you buy it?',
        home: GamePage(),
        debugShowCheckedModeBanner: false,
      );
    }
    else {
      return MaterialApp(
        title: 'Would you buy it?',
        home: GamePage(),
        debugShowCheckedModeBanner: false,
      );
    }
  }
}
