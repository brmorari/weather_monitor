import 'package:flutter/material.dart';
import 'package:weather_monitor/services/get_weather.dart';
import 'package:weather_monitor/widgets/weather_card.dart';

class WeatherListPage extends StatefulWidget {
  const new({super.key});

  @override
  State<WeatherListPage> createState() => _WeatherListPageState();
}

class _WeatherListPageState extends State<WeatherListPage> {
  final TextEditingController _cityController = TextEditingController();
  final List _cities = [];

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
                  controller: _cityController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Adicionar cidade',
                    suffixIcon: IconButton(
                      onPressed: () {
                        _getCurrentWeather();
                      },
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 50),
                  child: ListView.builder(
                    itemCount: _cities.length,
                    itemBuilder: (context, index) {
                      final informations = _cities[index];
                      return WeatherCard(
                        cityName: informations['location']['name'],
                        weatherCity:
                            informations['current']['condition']['text'],
                        temperature: informations['current']['temp_c'],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getCurrentWeather() async {
    try {
      final response = await getWeather(_cityController.text);
      setState(() {
        _cities.add(response);
      });
      _cityController.clear();
    } catch (e) {
      print('Erro: $e');
    }
  }
}
