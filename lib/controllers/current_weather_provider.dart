import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_sky_scrapper/models/current_weather.dart';
import '../utils/api_utils.dart';
import '../utils/functions.dart';

class CurrentWeatherProvider extends ChangeNotifier {
  late CurrentWeather currentWeather;
  static double latitude = 0;
  static double longitude = 0;

  Future<CurrentWeather> cityCurrentWeather(String city) async {
    // http://api.weatherapi.com/v1/current.json?key=b94da5b2d72e4e26a5d132250233105&q=Surat&aqi=no
    Uri url = Uri.parse("${WeatherApiUtils.baseUrl}"
        "/${WeatherApiUtils.api}"
        "?key=${WeatherApiUtils.key}"
        "&q=$city"
        "&aqi=${WeatherApiUtils.aqi}");
    var response1 = await http.get(url);
    if (response1.statusCode == 200) {
      currentWeather = currentWeatherFromJson(response1.body);
    } else {
      myToast("Something went wrong!");
    }
    return currentWeather;
  }

  Future<CurrentWeather> llCurrentWeather(
      double? latitude, double? longitude) async {
    Uri url = Uri.parse("${WeatherApiUtils.baseUrl}"
        "/${WeatherApiUtils.api}"
        "?key=${WeatherApiUtils.key}"
        "&q=$latitude,$longitude"
        "&aqi=${WeatherApiUtils.aqi}");
    var response2 = await http.get(url);
    if (response2.statusCode == 200) {
      currentWeather = currentWeatherFromJson(response2.body);
    } else {
      myToast("Something went wrong!");
    }
    return currentWeather;
  }
}
