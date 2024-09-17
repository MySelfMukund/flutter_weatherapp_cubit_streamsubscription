// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_cubit_steam_subscription/constants.dart/constants.dart';

import 'package:weather_app_cubit_steam_subscription/cubits/weather/weather_cubit.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  late StreamSubscription weatherStreamSubscription;
  final WeatherCubit weatherCubit;
  ThemeCubit({required this.weatherCubit}) : super(ThemeState.inital()) {
    weatherStreamSubscription = weatherCubit.stream.listen((WeatherState weatherState) {
      print(weatherState.weather.toString());
      if (weatherState.weather.temp > kWarmOrNot) {
        emit(state.copyWith(themeStatus: AppTheme.light));
      } else {
        emit(state.copyWith(themeStatus: AppTheme.dark));
      }
    });
  }

  @override
  Future<void> close() {
    weatherStreamSubscription.cancel();
    return super.close();
  }
}
