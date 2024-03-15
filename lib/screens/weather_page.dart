import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    //get current city
    String? cityName = await WeatherServices().getCurrentCity();
    //get weather for city
    try {
      final weatherr = await WeatherServices().getWeather(cityName);
      setState(() {
        _weather = weatherr;
      });
    } catch (e) {
      print("the error occurred is $e");
    }
  }

  //weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json'; //sunny as default
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/clouds.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                size: 29.0,
                color: Colors.grey[600],
              ),
              const SizedBox(
                height: 12.0,
              ),
              //city name
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                     _weather?.cityName ??"Loading city...",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.grey[600],
                          fontSize: 33.0,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '_',
                      style: TextStyle(color: Colors.grey[600], fontSize: 30.0),
                    ),
                  ),
                  Text(
                    _weather?.countryName ??" country..",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.grey[600],
                          fontSize: 33.0,
                        ),
                  ),
                ],
              ),

              //Animation
              Lottie.asset(
                getWeatherAnimation(_weather?.mainCondition),
                width: 200.0,
                height: 400.0,
              ),
              //description
              // Text(
              //   '${_weather?.description}',
              //   style: TextStyle(
              //     color: Colors.grey[600],
              //     fontSize: 20.0,
              //   ),
              // ),
              const SizedBox(
                height: 5.0,
              ),
              //temperature
              Text(
                '${_weather?.temperature.round()} °C',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
