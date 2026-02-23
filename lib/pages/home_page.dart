import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast_app/pages/weather_page.dart';
import 'package:weather_forecast_app/provider/weather_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();

    final weatherData = weatherProvider.weatherData;
    if (weatherData == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return WeatherPage(weatherData: weatherData);
  }
}
