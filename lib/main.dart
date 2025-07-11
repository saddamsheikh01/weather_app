import 'package:flutter/material.dart';
import 'package:weatherapp/screens/loading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  get parseWeatherData => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(parseWeatherData: parseWeatherData),
    );
  }
}
