import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/constants.dart';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherServices {
  Future<Weather?> getWeather(String? cityName) async {
    var url = Uri.parse(
        "${AppConstants.BASE_URL}${AppConstants.PATH}?key=${AppConstants.OPEN_WEATHER_API_KEY}&q=$cityName");

    var response = await http.get(url);
    if (response.statusCode == 200) {
      print('Request success with status: ${response.statusCode}.');
      // Use json decode method parses the string and returns the resulting Json object
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return null;
  }

//https://api.openweathermap.org/data/2.5/weather?q=egypt&appid=91487552a07a8cf8e5e292304133c59b
// another api: https://api.weatherapi.com/v1/current.json?key=2a27136913d341d7846204658241303&q=egypt

 // get current city method using geo locator and geo coding packages
  Future<String> getCurrentCity() async {
    //get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    //fetch the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    //convert the location into a list of placemark objects
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    //extract the city name from the first placemark
    String? city = placemarks[0].country;
    print("city is $city");
    return city ?? 'egypt';
  }
}
