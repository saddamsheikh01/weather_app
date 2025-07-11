import 'package:flutter/material.dart';
import 'package:weatherapp/data/my_location.dart';
import 'package:weatherapp/data/network.dart';

const apiKey = 'e785baf28c531b1eb151a95029c0376b';

class WeatherScreen extends StatefulWidget {
  final dynamic parseWeatherData;

  WeatherScreen({this.parseWeatherData});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late String cityName;
  late int temp;
  late String description;
  late String icon;

  @override
  void initState() {
    super.initState();
    updateData(widget.parseWeatherData);
  }

  void updateData(dynamic weatherData) {
    setState(() {
      double temp2 = weatherData['main']['temp'];
      temp = temp2.round();
      cityName = weatherData['name'];
      description = weatherData['weather'][0]['description'];
      icon = weatherData['weather'][0]['icon'];
    });
  }

  Future<void> refreshWeather() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();

    Network network = Network(
      'https://api.openweathermap.org/data/2.5/weather?lat=${myLocation.latitude2}&lon=${myLocation.longitude2}&appid=$apiKey&units=metric',
    );

    var weatherData = await network.getJsonData();
    updateData(weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('🌤️ Weather'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://openweathermap.org/img/wn/$icon@2x.png',
                  width: 100,
                ),
                const SizedBox(height: 16),
                Text(
                  cityName,
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  '$description'.toUpperCase(),
                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                ),
                const SizedBox(height: 24),
                Text(
                  '$temp°C',
                  style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: refreshWeather,
        backgroundColor: Colors.blueAccent,
        icon: const Icon(Icons.refresh),
        label: const Text("Refresh"),
      ),
    );
  }

}
