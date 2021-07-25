import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:would_you_buy_it/models/house.dart';

class DescriptionBox extends StatelessWidget {
  final House house;
  DescriptionBox({
    required this.house
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
              Text('Year: ${house.year}'),
              Text('EnergyClass: ${house.energyClass}'),
              Text('EstateType: ${house.estateType}'),
              Text('LivingSpace: ${house.livingSpace}'),
              Text('Rooms: ${house.rooms}'),
              Text('Municipality: ${house.municipality}'),
              Text('City: ${house.city}'),
              Text('Zipcode: ${house.zipCode}')
    ]);
  }
}