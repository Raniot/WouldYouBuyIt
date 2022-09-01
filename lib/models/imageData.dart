import 'package:would_you_buy_it/rest/json.dart';

class ImageData {
  String largeImageUrl;
  String lowResTabletImageUrl;
  String thumbnailUrl;
  String type;

  ImageData({
    required this.largeImageUrl,
    required this.lowResTabletImageUrl,
    required this.thumbnailUrl,
    required this.type
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      largeImageUrl: json['largeImageUrl'],
      lowResTabletImageUrl: json['lowResTabletImageUrl'],
      thumbnailUrl: json['thumbnailUrl'],
      type: json['type'],
    );
  }

  factory ImageData.fromJsonObject(JsonObject json) {
    return ImageData(
      largeImageUrl: json.mandatoryString('largeImageUrl'), 
      lowResTabletImageUrl: json.mandatoryString('lowResTabletImageUrl'), 
      thumbnailUrl: json.mandatoryString('thumbnailUrl'), 
      type: json.mandatoryString('type'),
    );
  }
}