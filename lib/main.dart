import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:would_you_buy_it/services/WouldYouBuyItService.dart';
import 'package:would_you_buy_it/widgets/Alert.dart';
import 'package:would_you_buy_it/widgets/description.dart';
import 'package:would_you_buy_it/widgets/guessWidget.dart';
import 'package:would_you_buy_it/widgets/imagePanel.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'models/house.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Would you buy it?',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Would you buy it?'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<House> _future;

  @override
  void initState() {
    super.initState();
    _future = WouldYouBuyItService().getHouse();
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
                Fluttertoast.showToast(msg: 'Error - Failed to fetch house, retrying...');
                setState(() {
                  _future = WouldYouBuyItService().getHouse();
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
          Guess(
              onPressed: (int guess) => {
                    showGuessDialog(context, guess, snapshot.requireData.price),
                    this.setState(() {
                      _future = WouldYouBuyItService().getHouse();
                    })
                  }),
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
          Guess(
              onPressed: (int guess) => {
                    showGuessDialog(context, guess, snapshot.requireData.price),
                    this.setState(() {
                      _future = WouldYouBuyItService().getHouse();
                    })
                  }),
          Spacer(),
          DescriptionBox(house: snapshot.requireData),
          Spacer(),
          ImagePanel(
            images: snapshot.requireData.imageData,
            height: MediaQuery.of(context).size.height * 0.33,
            width: MediaQuery.of(context).size.width * 0.9,
          )
        ],
      )
    ];
  }
}
