import 'package:flutter/material.dart';

import '../screens/weather_details.dart';

class WeatherCard extends StatelessWidget {
  final String cityName;
  final String weatherCity;
  final double temperature;
  final String iconLink;

  new({
    super.key,
    required this.cityName,
    required this.weatherCity,
    required this.temperature,
    required this.iconLink,
  });

  late String formatedIconLink = iconLink.startsWith('//')
      ? 'https:$iconLink'
      : iconLink;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.only(top: 5),
      child: Card(
        clipBehavior: .hardEdge,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WeatherDetailsPage(city: cityName),
              ),
            );
          },
          splashColor: Colors.blue.withAlpha(30),
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
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Image.network(formatedIconLink, fit: BoxFit.contain),
                ),
                SizedBox(width: 25),
                Text('$temperature °C'),
                SizedBox(width: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
