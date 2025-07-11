import 'package:flutter/material.dart';
import 'package:weatherapp/data/my_location.dart';
import 'package:weatherapp/data/network.dart';
import 'package:weatherapp/screens/weather_screen.dart';

const String apiKey = 'e785baf28c531b1eb151a95029c0376b';

class LocationFetcherScreen extends StatefulWidget {
  const LocationFetcherScreen({super.key});

  @override
  State<LocationFetcherScreen> createState() => _LocationFetcherScreenState();
}

class _LocationFetcherScreenState extends State<LocationFetcherScreen> {
  bool isLoading = false;

  Future<void> _getAndNavigateToWeather() async {
    setState(() => isLoading = true);

    try {
      MyLocation myLocation = MyLocation();
      await myLocation.getMyCurrentLocation();

      final double latitude = myLocation.latitude2;
      final double longitude = myLocation.longitude2;

      debugPrint("📍 Location: $latitude, $longitude");

      Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric',
      );

      var weatherData = await network.getJsonData();

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WeatherScreen(parseWeatherData: weatherData),
        ),
      );
    } catch (e) {
      debugPrint("❌ Error fetching location/weather: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to fetch weather. Please try again.")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: isLoading
            ? Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              "Fetching your local weather...\nPlease wait 🌍",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        )
            : ElevatedButton.icon(
          onPressed: _getAndNavigateToWeather,
          icon: const Icon(Icons.location_on),
          label: const Text('Get My Weather'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

