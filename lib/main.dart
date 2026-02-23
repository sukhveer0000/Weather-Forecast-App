import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast_app/pages/city_weather_page.dart';
import 'package:weather_forecast_app/pages/home_page.dart';
import 'package:weather_forecast_app/pages/loading_page.dart';
import 'package:weather_forecast_app/provider/city_weather_provider.dart';
import 'package:weather_forecast_app/provider/weather_provider.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WeatherProvider(),),
        ChangeNotifierProvider(create: (context) => CityWeatherProvider(),)
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => LoadingScreen(),
          '/home': (context) => HomePage(),
          '/city': (context) => CityWeatherData(),
        },
      ),
    );
  }
}
