import 'dart:convert';

import 'package:would_you_buy_it/models/house.dart';
import 'package:http/http.dart' as http;

class WouldYouBuyItService {
  final Uri _url = Uri(host: 'http://localhost', path: "api/house", port: 8080);

  Future<House> getHouse() async {
    var response = await http.get(_url);
    if(response.statusCode != 200)
      throw new Exception('Error from backend ${response.body}');
    
    return House.fromJson(jsonDecode(response.body));
  }
}