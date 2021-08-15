import 'package:would_you_buy_it/models/imageData.dart';

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
}