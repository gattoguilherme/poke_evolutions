import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ApiBaseHelper {
  final String _baseUrl = "https://pokeapi.co/api/v2/";

  Future<dynamic> get(String url) async {
    print('Api Get, url $url');
    var responseJson;

    try {
      final response = await http.get(_baseUrl + url);
      responseJson = json.decode(response.body.toString());
    } on SocketException {
      print("Erro na chamada da url $url");
    }
    print('api get recieved!');
    return responseJson;
  }
}
