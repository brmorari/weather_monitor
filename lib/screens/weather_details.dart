import 'package:flutter/material.dart';

class WeatherDetailsPage extends StatelessWidget {
  final String city;

  const new({super.key, required this.city});

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
      body: Center(),
    );
  }
}
