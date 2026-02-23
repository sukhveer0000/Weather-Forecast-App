import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather_forecast_app/utils/permissions.dart';
import 'package:weather_forecast_app/weather_model/forecast_response.dart';
import 'package:http/http.dart' as http;

class WeatherProvider with ChangeNotifier {
  final apiID = "b1d8680d132f21a1915e7512c40291d9";
  final lat = WeatherFlowService().lat;
  final lon = WeatherFlowService().lon;
  String get uri =>
      "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&units=metric&appid=$apiID";

  WeatherResponse? _weatherData;
  bool _isLoading = false;

  WeatherResponse? get weatherData => _weatherData;
  bool get isLoading => _isLoading;

  Future<void> fetchWeatherData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        _weatherData = WeatherResponse.fromJson(json.decode(response.body));
      }
    } catch (e) {
      throw e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
