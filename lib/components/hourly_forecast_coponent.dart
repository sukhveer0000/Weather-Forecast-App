import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast_app/weather_model/forecast_response.dart';

class HourlyForecastComponent extends StatelessWidget {
  final WeatherResponse? weatherData;
  const HourlyForecastComponent({super.key,required this.weatherData});

  String getWeatherIcon(String iconCode) {
    switch (iconCode) {
      case '01d':
        return 'assets/icons/sunny.png';
      case '01n':
        return 'assets/icons/clear_night.png';
      case '02d':
      case '03d':
      case '04d':
        return 'assets/icons/cloudy_day.png';
      case '02n':
      case '03n':
      case '04n':
        return 'assets/icons/cloudy_night.png';
      case '09d':
      case '10d':
        return 'assets/icons/rain_day.png';
      case '09n':
      case '10n':
        return 'assets/icons/rain_night.png';
      case '11d':
      case '11n':
        return 'assets/icons/thunder.png';
      case '13d':
      case '13n':
        return 'assets/icons/snow.png';
      case '50d':
      case '50n':
        return 'assets/icons/mist.png';
      default:
        return 'assets/icons/sunny.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (weatherData == null) return const SizedBox.shrink();

    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(), 
        padding: const EdgeInsets.symmetric(horizontal: 5),
        itemCount: 8, 
        itemBuilder: (context, index) {
          final weatherItem = weatherData!.list[index];
          final time = DateTime.parse(weatherItem.dtTxt).toLocal();
          final iconCode = weatherItem.weather[0].icon;
          final imagePath = getWeatherIcon(iconCode);

          String formattedTime = index == 0
              ? "Now"
              : DateFormat("ha").format(time);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formattedTime,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Image.asset(
                  imagePath,
                  width: 32,
                  height: 32,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.wb_cloudy, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  "${weatherItem.main.temp.toStringAsFixed(0)}°",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
