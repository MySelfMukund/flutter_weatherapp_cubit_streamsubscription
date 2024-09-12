import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_cubit_steam_subscription/cubits/weather/weather_cubit.dart';

import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _city;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
            onPressed: () async {
              _city = await Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage()));
              print(_city);
              context.read<WeatherCubit>().getWeather(_city!);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: Text('Home Page')),
      ),
    );
  }
}
