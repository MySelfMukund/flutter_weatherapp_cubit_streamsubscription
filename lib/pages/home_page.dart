import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_cubit_steam_subscription/cubits/weather/weather_cubit.dart';
import 'package:weather_app_cubit_steam_subscription/widgets/eror_dialog.dart';

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
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<WeatherCubit, WeatherState>(listener: (context, state) {
            if (state.status == WeatherStatus.error) {
              errorDialog(context, state.error.toString());
            }
          }, builder: (context, state) {
            if (state.status == WeatherStatus.initial) {
              return initalWidget(context);
            }
            if (state.status == WeatherStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.status == WeatherStatus.error && state.weather.name == '') {
              return initalWidget(context);
            }
            return Center(
              child: Text(
                state.weather.name,
                style: const TextStyle(fontSize: 18),
              ),
            );
          }),
        ));
  }

  Widget initalWidget(BuildContext context) {
    return const Center(
      child: Text(
        'Enter a city',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
