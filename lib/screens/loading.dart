import 'package:flutter/material.dart';
import 'package:weatherapp/data/my_location.dart';
import 'package:weatherapp/data/network.dart';
import 'package:weatherapp/screens/weather_screen.dart';
const apiKey = 'e785baf28c531b1eb151a95029c0376b';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  late double latitude3;
  late double longitude3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  void getLocation() async{
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;
    print(latitude3);
    print(longitude3);

    Network network = Network('https://api.openweathermap.org/data/2.5/weather'
        '?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric');

    var weatherData = await network.getJsonData();
    print(weatherData);
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(parseWeatherData: weatherData,);
    }));
  }

  // void fetchData() async{
  //
  //     var myJson = parsingData['weather'][0]['description'];
  //     print(myJson);
  //
  //     var wind = parsingData['wind']['speed'];
  //     print(wind);
  //
  //     var id =parsingData['id'];
  //     print(id);
  //   }else{
  //     print(response.statusCode);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: null,
          child: Text(
            'Get my location',
            style: TextStyle(
                color: Colors.white
            ),
          ),
          color: Colors.blue,
        ),
      ),
    );
  }
}

RaisedButton({required onPressed, required Text child, required MaterialColor color}) {
}