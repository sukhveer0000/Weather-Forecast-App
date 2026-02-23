import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast_app/weather_model/forecast_response.dart';

class CityWeatherProvider with ChangeNotifier {
  final String apiID = "b1d8680d132f21a1915e7512c40291d9";

  WeatherResponse? _weatherData;
  bool _loading = false;

  WeatherResponse? get weatherData => _weatherData;
  bool get loading => _loading;

  Future<void> searchCityWeather(String cityName) async {
    _weatherData = null;
    notifyListeners();
    String uri =
        "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&units=metric&appid=$apiID";

    _loading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        _weatherData = WeatherResponse.fromJson(json.decode(response.body));
      }
    } catch (e) {
      _weatherData = null;
      throw e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
