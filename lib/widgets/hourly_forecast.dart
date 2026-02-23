import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget {
  final String time;
  final String icon;
  final String temprature;
  const HourlyForecast({
    super.key,
    required this.time,
    required this.icon,
    required this.temprature,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time, style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(height: 5),
          Image.asset(icon, height: 30, width: 30, fit: BoxFit.cover),
          SizedBox(height: 5),
          Text(temprature, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
