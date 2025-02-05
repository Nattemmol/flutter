// bloc/weather_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'weather_event.dart';
import 'weather_state.dart';
import '../services/weather_api.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherApi weatherApi;

  WeatherBloc(this.weatherApi) : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather = await weatherApi.fetchWeather(event.cityName);
        emit(WeatherLoaded(weather));
      } catch (e) {
        emit(WeatherError("Failed to fetch weather data"));
      }
    });
  }
}
