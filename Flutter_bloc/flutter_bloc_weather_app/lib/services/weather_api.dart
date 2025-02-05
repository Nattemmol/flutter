// services/weather_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherApi {
  static const String apiKey = 'YOUR_API_KEY'; // Replace with your OpenWeatherMap API key
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  // Function to fetch weather data from OpenWeatherMap API
  Future<Weather> fetchWeather(String cityName) async {
    final response = await http.get(Uri.parse('$baseUrl?q=$cityName&appid=$apiKey'));

    if (response.statusCode == 200) {
      // Parse the JSON data and return a Weather object
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
