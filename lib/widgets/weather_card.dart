import 'package:flutter/material.dart';

import '../screens/weather_details.dart';

class WeatherCard extends StatefulWidget {
  final String cityName;
  final String weatherCity;
  final double temperature;
  final String iconLink;

  const new({
    super.key,
    required this.cityName,
    required this.weatherCity,
    required this.temperature,
    required this.iconLink,
  });

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  late String formatedIconLink = widget.iconLink.startsWith('//')
      ? 'https:${widget.iconLink}'
      : widget.iconLink;

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
                builder: (context) => WeatherDetailsPage(city: widget.cityName),
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
                    title: Text(widget.cityName),
                    subtitle: Text(widget.weatherCity),
                  ),
                ),
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Image.network(formatedIconLink, fit: BoxFit.contain),
                ),
                SizedBox(width: 25),
                Text('${widget.temperature} °C'),
                SizedBox(width: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
