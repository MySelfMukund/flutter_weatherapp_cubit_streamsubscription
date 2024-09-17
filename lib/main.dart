import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app_cubit_steam_subscription/cubits/weather/weather_cubit.dart';
import 'package:weather_app_cubit_steam_subscription/pages/home_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'cubits/temp_setting/temp_setting_cubit.dart';
import 'cubits/theme_cubit/theme_cubit.dart';
import 'repositors/weather_repository.dart';
import 'services/weather_servces.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(weatherApiServces: WeatherApiServices(httpClient: http.Client())),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherCubit>(create: (context) => WeatherCubit(weatherRepository: context.read<WeatherRepository>())),
          BlocProvider<TempSettingCubit>(create: (context) => TempSettingCubit()),
          BlocProvider<ThemeCubit>(create: (context) => ThemeCubit(weatherCubit: context.read<WeatherCubit>()))
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Weather App',
              theme: state.appTheme == AppTheme.light ? ThemeData.light() : ThemeData.dark(),
              // ThemeData(
              //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), // useMaterial3: true,
              // ),
              routes: {
                '/': (context) => const HomePage(),
              },
            );
          },
        ),
      ),
    );
  }
}
