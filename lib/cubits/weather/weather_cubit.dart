import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/custom_error.dart';
import '../../models/weather.dart';
import '../../repositors/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherCubit({required this.weatherRepository}) : super(WeatherState.initial());

  Future<Weather?> getWeather(String city) async {
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final Weather weather = await weatherRepository.getWeather(city);
      emit(state.copyWith(weather: weather, status: WeatherStatus.loaded));

      return weather;
    } on CustomError catch (e) {
      emit(state.copyWith(error: e, status: WeatherStatus.error));
    }
    return null;
  }
}
