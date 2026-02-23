import 'package:weather_forecast_app/weather_model/city.dart';
import 'package:weather_forecast_app/weather_model/forecast_item.dart';

class WeatherResponse {
  final String cod;
  final int message;
  final int cnt;
  final List<ForecastItem> list;
  final City city;

  WeatherResponse({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      cod: json['cod'],
      message: json['message'],
      cnt: json['cnt'],
      list: (json['list'] as List)
          .map((e) => ForecastItem.fromJson(e))
          .toList(),
      city: City.fromJson(json['city']),
    );
  }
}
