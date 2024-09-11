import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/weather/weather_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    //
    _fetchWeather();
    super.initState();
  }

  Future<void> _fetchWeather() async {
    context.read<WeatherCubit>().getWeather('London');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Home  Page'),
      ),
    );
  }
}
