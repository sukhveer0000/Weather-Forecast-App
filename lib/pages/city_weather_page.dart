import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast_app/pages/weather_page.dart';
import 'package:weather_forecast_app/provider/city_weather_provider.dart';

class CityWeatherData extends StatefulWidget {
  const CityWeatherData({super.key});

  @override
  State<CityWeatherData> createState() => _CityWeatherDataState();
}

class _CityWeatherDataState extends State<CityWeatherData> {
  final controller = TextEditingController();

  Future<void> handleSearch(String value) async {
    try {
      if (value.trim().isEmpty) return;

      final provider = Provider.of<CityWeatherProvider>(context, listen: false);

      // Capitalize first letter logic
      final city = '${value[0].toUpperCase()}${value.substring(1)}';

      // Show Loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) =>
            const Center(child: CircularProgressIndicator(color: Colors.white)),
      );

      await provider.searchCityWeather(city.trim());

      if (!mounted) return;
      Navigator.pop(context); // Close loading

      if (provider.weatherData != null) {
        controller.clear();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                WeatherPage(weatherData: provider.weatherData!),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("City not found! Please try again.")),
        );
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context); 
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong. Check your internet."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Search City",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "Find the weather forecast for any city",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 30),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                  child: TextField(
                    controller: controller,
                    style: const TextStyle(color: Colors.white),
                    textInputAction: TextInputAction.search,
                    onChanged: (val) => setState(() {}),
                    onSubmitted: (value) => handleSearch(value),
                    decoration: InputDecoration(
                      hintText: "Enter city name...",
                      hintStyle: const TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white70,
                      ),
                      suffixIcon: controller.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                controller.clear();
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white70,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Center(
                  child: Opacity(
                    opacity: 0.5,
                    child: Column(
                      children: [
                        Icon(
                          Icons.location_city,
                          size: 100,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Start typing to search...",
                          style: TextStyle(color: Colors.white54),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
