import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast_app/components/additional_parameter.dart';
import 'package:weather_forecast_app/components/hourly_forecast_coponent.dart';
import 'package:weather_forecast_app/weather_model/forecast_response.dart';

class WeatherPage extends StatefulWidget {
  final WeatherResponse? weatherData;
  const WeatherPage({super.key, required this.weatherData});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String _dateFormat(String dtText) {
    final date = DateTime.parse(dtText).toLocal();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final forecastDate = DateTime(date.year, date.month, date.day);
    final difference = forecastDate.difference(today).inDays;
    String weekDay = DateFormat("EEEE").format(forecastDate);

    if (difference == 0) return "Today";
    if (difference == 1) return "Tomorrow";
    return weekDay;
  }

  IconData _getWeatherIcon(String main) {
    switch (main) {
      case 'Clouds':
        return Icons.cloud;
      case 'Rain':
        return Icons.umbrella;
      case 'Clear':
        return Icons.wb_sunny;
      case 'Snow':
        return Icons.ac_unit;
      default:
        return Icons.wb_cloudy;
    }
  }

  LinearGradient getWeatherGradient(String main) {
    if (main == 'Clear') {
      return const LinearGradient(
        colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (main == 'Clouds') {
      return const LinearGradient(
        colors: [Color(0xFF606c88), Color(0xFF3f4c6b)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      return const LinearGradient(
        colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.weatherData == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final currentItem = widget.weatherData!.list[0];
    final temp = currentItem.main.temp.toInt();
    final sky = currentItem.weather[0].main;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.weatherData!.city.name,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/city');
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(gradient: getWeatherGradient(sky)),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "$temp°",
                      style: TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      sky.toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 4,
                        fontWeight: FontWeight.w800,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      "H:${currentItem.main.tempMax.toInt()}°  L:${currentItem.main.tempMin.toInt()}°",
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),

                    const SizedBox(height: 40),
                    _buildGlasscard(
                      title: "HOURLY FORECAST",
                      icon: Icons.access_time,
                      child: HourlyForecastComponent(
                        weatherData: widget.weatherData,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildGlasscard(
                      title: "5-DAY FORECAST",
                      icon: Icons.calendar_month,
                      child: Column(
                        children: List.generate(5, (index) {
                          final item = widget.weatherData!.list[index * 8];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 90,
                                  child: Text(
                                    _dateFormat(item.dtTxt),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Icon(
                                  _getWeatherIcon(item.weather[0].main),
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 90,
                                  child: Text(
                                    "${item.main.tempMin.toInt()}° / ${item.main.tempMax.toInt()}°",
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AdditionalParameter(weatherData: widget.weatherData),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlasscard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white.withValues(alpha: 0.15),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white70, size: 16),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const Divider(color: Colors.white24),
          child,
        ],
      ),
    );
  }
}
