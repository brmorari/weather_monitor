import 'package:http/http.dart' as http;

import 'dart:convert';

Future<Map<String, dynamic>> getWeather(String city) async {
  final url = Uri.parse(
    'https://api.weatherapi.com/v1/current.json?key=e5c0cd66c8f8445199d170307261809&q=$city',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception('Erro ao buscar universidade');
  }
}
