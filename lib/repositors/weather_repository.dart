// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:weather_app_cubit_steam_subscription/models/custom_error.dart';

import '../exceptions/weather_exceptions.dart';
import '../models/direct_geocoding.dart';
import '../models/weather.dart';
import '../services/weather_servces.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServces;
  WeatherRepository({
    required this.weatherApiServces,
  });

  Future<Weather> getWeather(String city) async {
    try {
      final DirectGeocoding directGeocoding = await weatherApiServces.getDirectGeoCoding(city);

      print("Direct Geocoding: ${directGeocoding.toString()}");

      final Weather tempWeather = await weatherApiServces.getWeather(directGeocoding);

      final Weather weather = tempWeather.copyWith(name: directGeocoding.name, country: directGeocoding.country);
      print("Weather: ${weather.toString()}");
      return weather;
    } on WeatherExceptions catch (e) {
      throw CustomError(errMessage: e.message);
    } catch (e) {
      throw CustomError(errMessage: e.toString());
    }
  }
}
