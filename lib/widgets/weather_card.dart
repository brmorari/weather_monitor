import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String cityName;
  final String weatherCity;
  final int temperature;

  const new({
    super.key,
    required this.cityName,
    required this.weatherCity,
    required this.temperature,
    required weatherIcons,
  });

  static Map<String, IconData> weatherIcons = {
    'Ensolarado': Icons.wb_sunny,
    'Chuvoso': Icons.thunderstorm,
    'Chuva': Icons.beach_access,
    'Nublado': Icons.cloud,
    'Parcialmente_nublado': Icons.cloud_queue,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.only(top: 5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text(cityName),
                  subtitle: Text(weatherCity),
                ),
              ),
              Icon(weatherIcons[weatherCity]),
              SizedBox(width: 25),
              Text('$temperature° Graus'),
              SizedBox(width: 15),
            ],
          ),
        ),
      ),
    );
  }
}
