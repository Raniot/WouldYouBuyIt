import 'package:http/http.dart' as http;
import 'package:would_you_buy_it/rest/json.dart';
import 'package:would_you_buy_it/rest/jsonObjectMapper.dart';

import '../models/house.dart';

Future<House> fetchHouse() async {
  return await fetch('https://wouldyoubuyitapi.azurewebsites.net/api/house', House.fromJson);
}

Future<T> fetch<T>(String uri, T Function(JsonObject json) mapper) async {
  for(var i = 0; i < 5; i++) {
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      return jsonObjectMapper(mapper).map(response);
    }
  }

  throw Exception('Error fetching data at $uri');
}