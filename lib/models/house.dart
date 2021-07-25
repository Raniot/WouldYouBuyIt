import 'dart:convert';

import 'package:would_you_buy_it/models/imageData.dart';

class House {
  String year;
  String energyClass;
  String estateType;
  String livingSpace;
  String rooms;

  String municipality;
  String city;
  String zipCode;

  List<ImageData> imageData;

  House({
    required this.year,
    required this.energyClass,
    required this.estateType,
    required this.livingSpace,
    required this.rooms,
    required this.municipality,
    required this.city,
    required this.zipCode,
    required this.imageData
  });

  factory House.fromJson(Map<String, dynamic> json){
    List<ImageData> imageData = [];

    for(int i = 0; i < json['images'].length; i++) {
      imageData.add(ImageData.fromJson(json['images'][i]));
    }
    
    return House(
      year: json['year'],
      energyClass: json['energyClass'],
      estateType: json['estateType'],
      livingSpace: json['livingSpace'],
      rooms: json['rooms'],
      municipality: json['municipality'],
      city: json['city'],
      zipCode: json['zipCode'],
      imageData: imageData
    );
  }
}