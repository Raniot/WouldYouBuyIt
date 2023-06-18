import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/house.dart';

Future<House> fetchHouse() async {
  return await fetch('https://wouldyoubuyitapi.azurewebsites.net/api/house', House.fromJson);
}

Future<T> fetch<T>(String uri, T Function(Map<String, dynamic> json) mapper) async {
  for(var i = 0; i < 5; i++) {
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      return mapper(jsonDecode(response.body));
    }
  }

  throw Exception('Error fetching data at $uri');
}