import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:would_you_buy_it/WouldYouBuyItService.dart';

class DescriptionBox extends StatelessWidget {
  var house = WouldYouBuyItService().getHouse();
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('This is some text')
        ],
      ),
    );
  }
}