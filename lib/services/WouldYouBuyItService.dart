import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/estate.dart';

Future<Estate> fetchEstate() async => fetch(
    'https://wouldyoubuyitapi.azurewebsites.net/api/house', Estate.fromJson);

Future<T> fetch<T>(
    String uri, T Function(Map<String, dynamic> json) mapper) async {
  return Future.value(mapper(dummy));
  // for(var i = 0; i < 5; i++) {
  //   final response = await http.get(Uri.parse(uri));
  //   if (response.statusCode == 200) {
  //     return mapper(jsonDecode(response.body));
  //   }
  // }

  // throw Exception('Error fetching data at $uri');
}

Map<String, dynamic> dummy = {
  'year': '1885',
  'energyClass': 'B',
  'estateType': 'Rækkehus',
  'livingSpace': '84',
  'rooms': '3',
  'floor': '',
  'municipality': 'Århus',
  'city': 'Viby J',
  'zipCode': '8260',
  'images': [
    {
      'lowResTabletImageUrl':
          'https://billeder.edc.dk/edcmedia/2023/05-May/05/f9b6474e-d167-40b8-bba0-f4aae4b08b55_Size3000x2000.jpg',
      'largeImageUrl':
          'https://billeder.edc.dk/edcmedia/2023/05-May/05/f9b6474e-d167-40b8-bba0-f4aae4b08b55_Size3000x2000.jpg',
      'thumbnailUrl':
          'https://billeder.edc.dk/edcmedia/2023/05-May/05/f9b6474e-d167-40b8-bba0-f4aae4b08b55_Size3000x2000.jpg',
      'type': 'image/jpeg',
    },
    {
      'lowResTabletImageUrl':
          'https://billeder.edc.dk/edcmedia/2023/05-May/05/629773c8-aa57-4d91-85dd-2bcd82e6511b_Size3000x2000.jpg',
      'largeImageUrl':
          'https://billeder.edc.dk/edcmedia/2023/05-May/05/629773c8-aa57-4d91-85dd-2bcd82e6511b_Size3000x2000.jpg',
      'thumbnailUrl':
          'https://billeder.edc.dk/edcmedia/2023/05-May/05/629773c8-aa57-4d91-85dd-2bcd82e6511b_Size3000x2000.jpg',
      'type': 'image/jpeg',
    },
  ],
  'monthlyExpenses': 2730.0,
  'price': 2595000.0,
};
