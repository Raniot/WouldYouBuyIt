import 'dart:convert';

import 'package:would_you_buy_it/models/house.dart';
import 'package:http/http.dart' as http;

class WouldYouBuyItService {
  final Uri _url = Uri(host: 'localhost', path: "api/house", port: 5000, scheme: 'http');

  Future<House> getHouse() async {
    var response = await http.get(Uri.parse('http://localhost:5000/api/house'),
    headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        });
    if(response.statusCode != 200)
      throw new Exception('Error from backend ${response.body}');
    
    return House.fromJson(jsonDecode(response.body));
  }
}