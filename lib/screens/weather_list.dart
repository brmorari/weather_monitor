import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_monitor/services/current_weather.dart';
import 'package:weather_monitor/widgets/weather_card.dart';

class WeatherListPage extends StatefulWidget {
  const new({super.key});

  @override
  State<WeatherListPage> createState() => _WeatherListPageState();
}

class _WeatherListPageState extends State<WeatherListPage> {
  final TextEditingController _cityController = TextEditingController();
  final List _cities = [];
  bool isLoading = false;

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
                  enabled: !isLoading,
                  controller: _cityController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Adicionar cidade',
                    suffixIcon: isLoading == true
                        ? Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SizedBox(
                              width: 8,
                              height: 8,
                              child: CircularProgressIndicator(
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              _getCurrentInformations(_cityController.text);
                            },
                            icon: Icon(Icons.search),
                          ),
                  ),
                ),
              ),
              _cities.isEmpty
                  ? Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 75),
                            child: Text(
                              textAlign: TextAlign.center,
                              'Adicione uma cidade para monitorar a temperatura.',
                            ),
                          ),
                          SizedBox(height: 250),
                        ],
                      ),
                    )
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 50),
                        child: RefreshIndicator(
                          onRefresh: _getRefreshInformations,
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: _cities.length,
                            itemBuilder: (context, index) {
                              final informations = _cities[index];
                              return WeatherCard(
                                cityName: informations['cityName'],
                                weatherCity: informations['weatherCity'],
                                temperature: informations['temperature'],
                                iconLink: informations['iconLink'],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getCurrentInformations(String city) async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await getCurrentWeather(city);

      var currentInformations = {
        "cityName": response['location']['name'],
        "weatherCity": response['current']['condition']['text'],
        "temperature": response['current']['temp_c'],
        "iconLink": response['current']['condition']['icon'],
      };

      setState(() {
        _cities.add(currentInformations);
      });
      _cityController.clear();
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<dynamic> _fetchCurrentInformations(String city) async {
    try {
      final response = await getCurrentWeather(city);
      return response;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<void> _getRefreshInformations() async {
    if (_cities.isEmpty) return;

    final refreshCity = await Future.wait(
      _cities.map((city) => _fetchCurrentInformations(city['cityName'])),
    );

    setState(() {
      for (var i = 0; i < _cities.length; i++) {
        final response = refreshCity[i];
        if (refreshCity[i] != null) {
          _cities[i] = {
            "cityName": response['location']['name'],
            "weatherCity": response['current']['condition']['text'],
            "temperature": response['current']['temp_c'],
            "iconLink": response['current']['condition']['icon'],
          };
        }
      }
    });
  }
}
