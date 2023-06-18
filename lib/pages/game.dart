import 'dart:math';

import 'package:flutter/material.dart';

import '../models/house.dart';
import '../services/WouldYouBuyItService.dart';
import '../widgets/alert.dart';
import '../widgets/description.dart';
import '../widgets/guessWidget.dart';
import '../widgets/imagePanel.dart';

class GamePage extends StatefulWidget {
  GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late Future<House> _future;
  var avgScore = 0.0;
  var guesses = 0.0;
  var totalScore = 0.0;

  @override
  void initState() {
    super.initState();
    _future = fetchHouse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.orange,
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          return FutureBuilder(
            future: _future,
            builder: (BuildContext context, AsyncSnapshot<House> snapshot) {
              List<Widget> children;
              if (snapshot.connectionState != ConnectionState.done) {
                children = const <Widget>[
                  CircularProgressIndicator(),
                ];
              } else if (snapshot.hasData) {
                children = orientation == Orientation.portrait
                    ? portraitMode(context, snapshot)
                    : landscapeMode(context, snapshot);
              }
              else if(snapshot.hasError) {
                children = [];
                setState(() {
                  _future = fetchHouse();
                });
              }
              else {
                children = const <Widget>[
                  CircularProgressIndicator(),
                ];
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
        })
    );
  }

  List<Widget> landscapeMode(
      BuildContext context, AsyncSnapshot<House> snapshot) {
    return [
      Spacer(),
      Column(
        children: [
          guessDialog(snapshot, context),
          Spacer(),
          DescriptionBox(house: snapshot.requireData),
          Spacer(),
        ],
      ),
      Spacer(),
      Column(
        children: [
          Spacer(),
          ImagePanel(
            images: snapshot.requireData.imageData,
            height: MediaQuery.of(context).size.height * 0.741,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          Spacer(),
        ],
      )
    ];
  }

  List<Widget> portraitMode(
      BuildContext context, AsyncSnapshot<House> snapshot) {
    return [
      Column(
        children: [
          Spacer(),
          ImagePanel(
            images: snapshot.requireData.imageData,
            height: MediaQuery.of(context).size.height * 0.33,
            width: MediaQuery.of(context).size.width * 0.9,
          ),
          Spacer(),
          guessDialog(snapshot, context),
          Spacer(),
          DescriptionBox(house: snapshot.requireData),
          Spacer(),
        ],
      )
    ];
  }

  Guess guessDialog(AsyncSnapshot<House> snapshot, BuildContext context) {
    return Guess(
            onPressed: (int guess) {
                  totalScore += min(((guess - snapshot.requireData.price).abs()*10)/snapshot.requireData.price, 10);
                  avgScore = totalScore / ++guesses;
                  showGuessDialog(context, guess, snapshot.requireData.price, avgScore);
                  this.setState(() {
                    _future = fetchHouse();
                  });
                });
  }
}