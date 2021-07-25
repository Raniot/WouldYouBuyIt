import 'dart:convert';

import 'package:would_you_buy_it/models/house.dart';
import 'package:http/http.dart' as http;

class WouldYouBuyItService {
  final Uri _url = Uri(host: 'localhost', path: "api/house", port: 5000, scheme: 'http');

  Future<House> getHouse() async {
    var response = await http.get(Uri.parse('https://wouldyoubuyitapi.azurewebsites.net/api/house'));
    if(response.statusCode != 200)
      throw new Exception('Error from backend ${response.body}');
    
    return House.fromJson(jsonDecode(response.body));
  }
}