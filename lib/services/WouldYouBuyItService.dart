import 'dart:convert';

import 'package:would_you_buy_it/models/house.dart';
import 'package:http/http.dart' as http;

class WouldYouBuyItService {
  Future<House> getHouse() async {
    for(int i = 0; i < 5; i ++) {
      var response = await http.get(Uri.parse('https://wouldyoubuyitapi.azurewebsites.net/api/house'));
      if(response.statusCode == 200) {
        return House.fromJson(jsonDecode(response.body));
      }
    }

    throw Exception("Error fetching house");
  }
}