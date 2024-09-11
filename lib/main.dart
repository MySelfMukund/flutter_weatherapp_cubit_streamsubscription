import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app_cubit_steam_subscription/cubits/weather/weather_cubit.dart';
import 'package:weather_app_cubit_steam_subscription/pages/home_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

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
        providers: [BlocProvider(create: (context) => WeatherCubit(weatherRepository: context.read<WeatherRepository>()))],
        child: MaterialApp(
          title: 'Weather App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routes: {
            '/': (context) => const HomePage(),
          },
          // home: const MyHomePage(),
        ),
      ),
    );
  }
}
