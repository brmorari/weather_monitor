import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:weather_monitor/services/app_config.dart';

Future<Map<String, dynamic>> getCurrentWeather(String city) async {
  final String apiKey = AppConfig.apiKey;

  final url = Uri.https('api.weatherapi.com', '/v1/current.json', {
    'key': apiKey,
    'q': city,
    'lang': 'pt',
  });
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data;
  }
  throw Exception('Erro ao buscar uma cidade');
}
