import 'package:flutter/material.dart';
import 'package:weather_forecast_app/weather_model/forecast_response.dart';

class AdditionalParameter extends StatelessWidget {
  final WeatherResponse? weatherData;
  const AdditionalParameter({super.key,required this.weatherData});

  @override
  Widget build(BuildContext context) {
    

    if (weatherData == null) return const SizedBox.shrink();

    final weatherItem = weatherData!.list[0];

    final List<Map<String, dynamic>> details = [
      {
        'label': 'Wind Speed',
        'value': '${(weatherItem.wind.speed * 3.6).toStringAsFixed(1)} km/h',
        'icon': Icons.air,
      },
      {
        'label': 'Humidity',
        'value': '${weatherItem.main.humidity}%',
        'icon': Icons.opacity,
      },
      {
        'label': 'Visibility',
        'value': '${(weatherItem.visibility / 1000).toStringAsFixed(1)} km',
        'icon': Icons.visibility,
      },
      {
        'label': 'Pressure',
        'value': '${weatherItem.main.pressure} hPa',
        'icon': Icons.speed,
      },
      {
        'label': 'Sea Level',
        'value': '${weatherItem.main.seaLevel} hPa',
        'icon': Icons.water,
      },
      {
        'label': 'Ground Level',
        'value': '${weatherItem.main.groundLevel} hPa',
        'icon': Icons.landscape,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: details.length,
      itemBuilder: (context, index) {
        final item = details[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item['icon'], color: Colors.white70, size: 28),
              const SizedBox(height: 8),
              Text(
                item['label'],
                style: const TextStyle(color: Colors.white60, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                item['value'],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
