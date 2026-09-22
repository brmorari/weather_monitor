import 'package:flutter/material.dart';
import 'package:weather_monitor/screens/weather_history.dart';

class WeatherDetailsPage extends StatelessWidget {
  final String city;
  final String weatherCity;
  final double temperature;
  final String iconLink;
  final double wind;
  final int humidity;

  const WeatherDetailsPage({
    super.key,
    required this.city,
    required this.weatherCity,
    required this.temperature,
    required this.iconLink,
    required this.wind,
    required this.humidity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [Text(city, style: TextStyle(fontSize: 24))]),
        ),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
                Image(
                  image: NetworkImage(iconLink),
                  width: 90,
                  height: 90,
                  fit: BoxFit.contain,
                ),
                Text(
                  '$temperature°C',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8),
                Text(weatherCity, style: TextStyle(fontSize: 19)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 25),
                        Icon(Icons.water_drop, color: Colors.blue, size: 27),
                        SizedBox(width: 8),
                        Text('$humidity%', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    SizedBox(width: 30),
                    Row(
                      children: [
                        SizedBox(width: 30),
                        Icon(Icons.wind_power, size: 27),
                        SizedBox(width: 8),
                        Text('$wind km/h', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 35),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text('Previsão 7 dias', style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('Seg'), Text('Ter')],
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeatherHistoryPage(city: city),
                  ),
                );
              },
              child: Text(
                'Ver histórico 1 ano atrás',
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
          ),
          SizedBox(height: 70),
        ],
      ),
    );
  }
}
