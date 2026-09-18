import 'package:flutter/material.dart';
import 'package:weather_monitor/widgets/weather_card.dart';

class WeatherList extends StatefulWidget {
  const new({super.key});

  @override
  State<WeatherList> createState() => _WeatherListState();
}

class _WeatherListState extends State<WeatherList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Meu Clima', style: TextStyle(fontSize: 24)),
                Icon(Icons.nights_stay, size: 30),
              ],
            ),
          ),
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 30, 25, 40),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Adicionar cidade',
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 50),
                  child: ListView(
                    children: [
                      WeatherCard(
                        cityName: 'São Paulo',
                        weatherCity: 'Ensolarado',
                        temperature: 25,
                        weatherIcons: WeatherCard.weatherIcons['Ensolarado'],
                      ),
                      WeatherCard(
                        cityName: 'Campinas',
                        weatherCity: 'Chuvoso',
                        temperature: 14,
                        weatherIcons: WeatherCard.weatherIcons['Chuvoso'],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
