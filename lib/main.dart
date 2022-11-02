import 'package:flutter/material.dart';
import 'package:would_you_buy_it/state/game.dart';
import 'package:would_you_buy_it/state/user.dart';
import 'package:would_you_buy_it/widgets/description.dart';
import 'package:would_you_buy_it/widgets/guessWidget.dart';
import 'package:would_you_buy_it/widgets/imagePanel.dart';

import 'models/house.dart';

void main() {
  runApp(HousePriceGuesser());
}

class HousePriceGuesser extends StatelessWidget {
  final state = new GameState(
    users: [new User(id: '1', name: 'Player 1')],
    roundsToPlay: 5,
  );

  @override
  Widget build(BuildContext context) {
    const title = 'Would you buy it?';
    state.startRound();

    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameBoard(
        title: title,
        state: state,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GameBoard extends StatefulWidget {
  GameBoard({Key? key, required this.title, required this.state})
      : super(key: key);
  final String title;
  final GameState state;

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    final guessDialog = Guess(onPressed: (guess) {
      widget.state.makeGuess('1', guess);
    });
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.orange,
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          return ValueListenableBuilder(
            valueListenable: widget.state.house,
            builder: (context, house, child) {
              final List<Widget> children;
              if (house == null) {
                children = [CircularProgressIndicator()];
              } else {
                children = orientation == Orientation.portrait
                    ? portraitMode(context, house, guessDialog)
                    : landscapeMode(context, house, guessDialog);
              }

              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children,
                ),
              );
            },
          );
        }));
  }

  List<Widget> landscapeMode(BuildContext context, House house, Widget guess) {
    return [
      Spacer(),
      Column(
        children: [
          guess,
          Spacer(),
          DescriptionBox(house: house),
          Spacer(),
        ],
      ),
      Spacer(),
      Column(
        children: [
          Spacer(),
          ImagePanel(
            images: house.imageData,
            height: MediaQuery.of(context).size.height * 0.741,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          Spacer(),
        ],
      )
    ];
  }

  List<Widget> portraitMode(BuildContext context, House house, Widget guess) {
    return [
      Column(
        children: [
          Spacer(),
          ImagePanel(
            images: house.imageData,
            height: MediaQuery.of(context).size.height * 0.33,
            width: MediaQuery.of(context).size.width * 0.9,
          ),
          Spacer(),
          guess,
          Spacer(),
          DescriptionBox(house: house),
          Spacer(),
        ],
      )
    ];
  }
}
