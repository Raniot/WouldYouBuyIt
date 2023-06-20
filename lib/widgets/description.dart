import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:would_you_buy_it/models/estate.dart';

class DescriptionBox extends StatelessWidget {
  final Estate house;
  DescriptionBox({
    required this.house
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
              Text('Year: ${house.year}'),
              Text('EnergyClass: ${house.energyClass}'),
              Text('EstateType: ${house.estateType}'),
              house.expenses != 0 ? Text('Expenses: ${house.expenses} kr./month') : SizedBox.shrink(),
              Text('LivingSpace: ${house.livingSpace}'),
              Text('Rooms: ${house.rooms}'),
              house.floor != '' ? Text('Floor: ${house.floor}') : SizedBox.shrink(),
              Text('Municipality: ${house.municipality}'),
              Text('City: ${house.city}'),
              Text('Zipcode: ${house.zipCode}'),
    ]);
  }
}