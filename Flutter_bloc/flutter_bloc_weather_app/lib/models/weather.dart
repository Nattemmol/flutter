// models/weather.dart
class Weather {
  final String cityName;
  final double temperature;
  final String description;

  Weather({required this.cityName, required this.temperature, required this.description});

  // Factory constructor to create a Weather object from JSON
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'] - 273.15, // Convert Kelvin to Celsius
      description: json['weather'][0]['description'],
    );
  }
}
