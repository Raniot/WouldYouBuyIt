import 'package:would_you_buy_it/models/image.dart';

class House {
  String year;
  String energyClass;
  String estateType;
  String livingSpace;
  String rooms;

  String municipality;
  String city;
  String zipCode;

  List<ImageData> imageUris;

  House({
    this.year,
    this.energyClass,
    this.estateType,
    this.livingSpace,
    this.rooms,
    this.municipality,
    this.city,
    this.zipCode,
    this.imageUris
  });

  factory House.fromJson(Map<String, dynamic> json){
    return House(
      year: json['year'],
      energyClass: json['energyClass'],
      estateType: json['estateType'],
      livingSpace: json['livingSpace'],
      rooms: json['rooms'],
      municipality: json['municipality'],
      city: json['city'],
      zipCode: json['zipCode'],
      imageUris: json['imageUris']
    );
  }
}