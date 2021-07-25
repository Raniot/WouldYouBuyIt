import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:would_you_buy_it/WouldYouBuyItService.dart';
import 'package:would_you_buy_it/models/house.dart';

class DescriptionBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: WouldYouBuyItService().getHouse(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<Widget> children;
          if(snapshot.hasData) {
            var house = snapshot.data as House;
            children = <Widget>[
              Text('Year: ${house.year}'),
              Text('EnergyClass: ${house.energyClass}'),
              Text('EstateType: ${house.estateType}'),
              Text('LivingSpace: ${house.livingSpace}'),
              Text('Rooms: ${house.rooms}'),
              Text('Municipality: ${house.municipality}'),
              Text('City: ${house.city}'),
              Text('Zipcode: ${house.zipCode}')
            ];
          } else {
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
      )
    );
  }
}