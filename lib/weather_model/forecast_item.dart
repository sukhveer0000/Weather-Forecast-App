import 'package:weather_forecast_app/weather_model/clouds.dart';
import 'package:weather_forecast_app/weather_model/main_data.dart';
import 'package:weather_forecast_app/weather_model/rain.dart';
import 'package:weather_forecast_app/weather_model/sys.dart';
import 'package:weather_forecast_app/weather_model/weather_data.dart';
import 'package:weather_forecast_app/weather_model/wind.dart';

class ForecastItem {
  final int dt;
  final MainData main;
  final List<WeatherData> weather;
  final Clouds clouds;
  final Wind wind;
  final int visibility;
  final double pop;
  final Rain? rain; // optional
  final Sys sys;
  final String dtTxt;

  ForecastItem({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.rain,
    required this.sys,
    required this.dtTxt,
  });

  factory ForecastItem.fromJson(Map<String, dynamic> json) {
    return ForecastItem(
      dt: json['dt'],
      main: MainData.fromJson(json['main']),
      weather: (json['weather'] as List)
          .map((e) => WeatherData.fromJson(e))
          .toList(),
      clouds: Clouds.fromJson(json['clouds']),
      wind: Wind.fromJson(json['wind']),
      visibility: json['visibility'],
      pop: (json['pop'] as num).toDouble(),
      rain: json['rain'] != null
          ? Rain.fromJson(json['rain'])
          : null,
      sys: Sys.fromJson(json['sys']),
      dtTxt: json['dt_txt'],
    );
  }
}
