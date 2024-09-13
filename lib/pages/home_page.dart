import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:weather_app_cubit_steam_subscription/constants.dart/constants.dart';
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
          title: const Text('Weather', style: TextStyle(color: Colors.white)),
          backgroundColor: Theme.of(context).colorScheme.primary,
          actions: [
            IconButton(
              color: Colors.white,
              onPressed: () async {
                _city = await Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage()));
                print(_city);
                context.read<WeatherCubit>().getWeather(_city!);
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: _showWeather());
  }

  Widget showIcon(String iconName) {
    return FadeInImage.assetNetwork(
        width: 96, height: 96, placeholder: 'assets/images/loading.gif', image: 'http://$kIconHost/img/wn/$iconName@4x.png');
  }

  Widget formatText(String description) {
    final formattedDescription = description.titleCase;
    return Text(formattedDescription, style: const TextStyle(fontSize: 24), textAlign: TextAlign.center);
  }

  String showTemperatiure(double temp) {
    return '${temp.toStringAsFixed(2)}°C';
  }

  Widget _showWeather() {
    return Padding(
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
        return ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 6),
            Text(
              state.weather.name,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  TimeOfDay.fromDateTime(state.weather.lastUpdated).format(context),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 10),
                Text(
                  "(${state.weather.country})",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  showTemperatiure(state.weather.temp),
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    Text(
                      '${showTemperatiure(state.weather.tempMax)} max',
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${showTemperatiure(state.weather.tempMin)} min',
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 60),
            Row(
              children: [
                const Spacer(),
                showIcon(state.weather.icon),
                Expanded(
                  flex: 3,
                  child: formatText(state.weather.description),
                ),
                const Spacer()
              ],
            )
          ],
        );
      }),
    );
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
