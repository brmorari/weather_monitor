import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _keyCities = 'saved_cities';

  static Future<void> saveCities(List<Map<String, dynamic>> cities) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> jsonStringList = cities.map((city) {
      return jsonEncode(city);
    }).toList();

    await prefs.setStringList('saved_cities', jsonStringList);
  }

  static Future<List<Map<String, dynamic>>> getSavedCities() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String>? jsonStringList = prefs.getStringList(_keyCities);

    if (jsonStringList == null) return [];

    return jsonStringList.map((stringJson) {
      return jsonDecode(stringJson) as Map<String, dynamic>;
    }).toList();
  }
}
