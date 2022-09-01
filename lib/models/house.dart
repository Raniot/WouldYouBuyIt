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

  factory House.fromJson(JsonObject json) {
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
      imageData: json.objectList('images', (json) => ImageData.fromJson(json)),
      expenses: json.mandatoryInteger('monthlyExpenses'),
      price: json.mandatoryInteger('price'),
    );
  }
}