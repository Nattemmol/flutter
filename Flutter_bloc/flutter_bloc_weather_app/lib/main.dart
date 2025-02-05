import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'bloc/weather_bloc.dart';
import 'bloc/weather_event.dart';
import 'bloc/weather_state.dart';
import 'models/weather.dart';

class WeatherPage extends StatelessWidget {
  final cityController = TextEditingController();

  WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App', style: GoogleFonts.poppins(fontSize: 24)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          return Stack(
            children: [
              // Background image based on weather conditions
              if (state is WeatherLoaded)
                _buildBackgroundImage(state.weather),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: cityController,
                      style: GoogleFonts.poppins(fontSize: 18),
                      decoration: InputDecoration(
                        labelText: 'Enter city name',
                        labelStyle: GoogleFonts.poppins(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        final cityName = cityController.text;
                        if (cityName.isNotEmpty) {
                          context
                              .read<WeatherBloc>()
                              .add(FetchWeather(cityName));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('Get Weather',
                          style: GoogleFonts.poppins(fontSize: 18)),
                    ),
                    const SizedBox(height: 20),

                    // Display state conditions: Loading, Success, Error
                    if (state is WeatherInitial) ...[
                      Text('Enter a city to get weather',
                          style: GoogleFonts.poppins(fontSize: 18)),
                    ] else if (state is WeatherLoading) ...[
                      const SpinKitFadingCircle(color: Colors.blue, size: 50),
                    ] else if (state is WeatherLoaded) ...[
                      _buildWeatherContent(state.weather),
                    ] else if (state is WeatherError) ...[
                      Text(state.message,
                          style: GoogleFonts.poppins(
                              color: Colors.red, fontSize: 18)),
                    ],
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Builds weather data content
  Widget _buildWeatherContent(Weather weather) {
    return Column(
      children: [
        const SizedBox(height: 40),
        CachedNetworkImage(
          imageUrl:
              "https://openweathermap.org/img/wn/${_mapWeatherToIcon(weather.description)}@2x.png",
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        const SizedBox(height: 10),
        Text(
          weather.cityName,
          style: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          '${weather.temperature.toStringAsFixed(1)} °C',
          style: GoogleFonts.poppins(fontSize: 48, fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 10),
        Text(
          weather.description.toUpperCase(),
          style: GoogleFonts.poppins(fontSize: 20),
        ),
      ],
    );
  }

  // Builds background image based on weather condition
  Widget _buildBackgroundImage(Weather weather) {
    String imageUrl;
    if (weather.description.contains('cloud')) {
      imageUrl = 'https://example.com/cloudy_bg.jpg'; // Replace with actual images
    } else if (weather.description.contains('rain')) {
      imageUrl = 'https://example.com/rainy_bg.jpg';
    } else {
      imageUrl = 'https://example.com/sunny_bg.jpg';
    }

    return Positioned.fill(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  // Maps weather description to an OpenWeatherMap icon code
  String _mapWeatherToIcon(String description) {
    if (description.contains('cloud')) {
      return '03d'; // Cloud icon
    } else if (description.contains('rain')) {
      return '09d'; // Rain icon
    } else {
      return '01d'; // Clear sky
    }
  }
}
