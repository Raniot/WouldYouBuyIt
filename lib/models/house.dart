import 'package:would_you_buy_it/models/imageData.dart';
import 'package:would_you_buy_it/rest/json.dart';

class House {
  final String year;
  final String energyClass;
  final String estateType;
  final String livingSpace;
  final String rooms;
  final String floor;
  final int expenses;

  final String municipality;
  final String city;
  final String zipCode;

  final List<ImageData> imageData;

  final int price;

  House({
    required this.year,
    required this.energyClass,
    required this.estateType,
    required this.livingSpace,
    required this.rooms,
    required this.municipality,
    required this.city,
    required this.zipCode,
    required this.imageData,
    required this.price,
    this.expenses = 0,
    this.floor = '',
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
      floor: json['floor'] ?? '',
      municipality: json['municipality'],
      city: json['city'],
      zipCode: json['zipCode'],
      imageData: imageData,
      expenses: json['monthlyExpenses'],
      price: json['price'],
    );
  }

  factory House.fromJsonObject(JsonObject json) {
    return House(
      year: json.mandatoryString('year'),
      energyClass: json.mandatoryString('energyClass'),
      estateType: json.mandatoryString('estateType'),
      livingSpace: json.mandatoryString('livingSpace'),
      rooms: json.mandatoryString('rooms'),
      floor: json.string('floor') ?? '',
      municipality: json.mandatoryString('municipality'),
      city: json.mandatoryString('city'),
      zipCode: json.mandatoryString('zipCode'),
      imageData: json.objectList('images', (json) => ImageData.fromJsonObject(json)),
      expenses: json.mandatoryInteger('monthlyExpenses'),
      price: json.mandatoryInteger('price'),
    );
  }
}