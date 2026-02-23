import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_forecast_app/utils/permissions.dart'; 

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    WeatherFlowService().startAppFlow(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(), 
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.05),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/weather_logo.png',
                height: 160,
                width: 160,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "WEATHER APP",
              style: TextStyle(
                fontSize: 28,
                letterSpacing: 6,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 10),

            const SpinKitThreeBounce(color: Colors.white70, size: 30),

            const Spacer(),
            const Text(
              'MADE BY KABIR',
              style: TextStyle(
                fontSize: 12,
                letterSpacing: 2,
                color: Colors.white54,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
