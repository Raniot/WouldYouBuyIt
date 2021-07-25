import 'package:flutter/material.dart';
import 'package:would_you_buy_it/services/WouldYouBuyItService.dart';
import 'package:would_you_buy_it/widgets/description.dart';
import 'package:would_you_buy_it/widgets/guessWidget.dart';
import 'package:would_you_buy_it/widgets/imagePanel.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: WouldYouBuyItService().getHouse(),
        builder: (BuildContext context, AsyncSnapshot<House> snapshot) {
          List<Widget> children;
          if(snapshot.hasData) {
            children = <Widget>[
              // Guess(onPressed: () => {}),
              DescriptionBox(house: snapshot.requireData),
              ImagePanel(house: snapshot.requireData)
            ];
          } 
          //Make error handling -> else if(snapshot.hasError)
          else {
            children = const <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
