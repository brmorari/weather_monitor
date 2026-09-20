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
                            onPressed: _getCurrentWeather,
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
                          onRefresh: _getCurrentWeather,
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: _cities.length,
                            itemBuilder: (context, index) {
                              final informations = _cities[index];
                              return WeatherCard(
                                cityName: informations['location']['name'],
                                weatherCity:
                                    informations['current']['condition']['text'],
                                temperature: informations['current']['temp_c'],
                                iconLink:
                                    informations['current']['condition']['icon'],
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

  Future<void> _getCurrentWeather() async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await getWeather(_cityController.text);

      setState(() {
        _cities.add(response);
      });

      _cityController.clear();
    } catch (e) {
      print('Erro: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
