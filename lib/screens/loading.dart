import 'package:flutter/material.dart';
import 'package:weatherapp/data/my_location.dart';
import 'package:weatherapp/data/network.dart';
import 'package:weatherapp/screens/weather_screen.dart';

const apiKey = 'e785baf28c531b1eb151a95029c0376b';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key, required parseWeatherData});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late double latitude3;
  late double longitude3;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;
    print(latitude3);
    print(longitude3);

    Network network = Network(
      'https://api.openweathermap.org/data/2.5/weather'
          '?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric',
    );

    var weatherData = await network.getJsonData();
    print(weatherData);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeatherScreen(parseWeatherData: weatherData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: getLocation,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: const Text(
            'Get my location',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
