import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast_app/provider/weather_provider.dart';

class WeatherFlowService {
  WeatherFlowService._internal();
  static final _inatance = WeatherFlowService._internal();
  factory WeatherFlowService() => _inatance;

  double? _lat, _lon;

  double get lat => _lat ?? 0.0;
  double get lon => _lon ?? 0.0;

  Future<void> startAppFlow(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));

    if (!context.mounted) return;

    var connectivityResult = await (Connectivity().checkConnectivity());

    if (!context.mounted) return;

    if (connectivityResult.contains(ConnectivityResult.none)) {
      _showNoInternetDialog(context);
      return;
    }

    var status = await Permission.location.status;

    if (status.isGranted) {
      if (!context.mounted) return;
      _checkGPSSettings(context);
    } else if (status.isPermanentlyDenied) {
      if (!context.mounted) return;
      _showPermissionDialog(context);
    } else {
      var requestStatus = await Permission.location.request();

      if (!context.mounted) return;

      if (requestStatus.isGranted) {
        _checkGPSSettings(context);
      } else {
        _showPermissionDialog(context);
      }
    }
  }

  Future<void> _checkGPSSettings(BuildContext context) async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!context.mounted) return;

    if (isLocationServiceEnabled) {
      Position position = await Geolocator.getCurrentPosition();
      _lat = position.latitude;
      _lon = position.longitude;

      if (!context.mounted) return;

      await Provider.of<WeatherProvider>(
        context,
        listen: false,
      ).fetchWeatherData();

      if (!context.mounted) return;

      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      _showGPSDialog(context);
    }
  }

  void _showCustomDialog({
    required BuildContext context,
    required String title,
    required String content,
    required String confirmText,
    required VoidCallback onConfirm,
    bool showCancel = true,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          ),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.info_outline, color: Colors.white, size: 40),
                const SizedBox(height: 15),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    if (showCancel)
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              '/city',
                              (route) => false,
                            );
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white60),
                          ),
                        ),
                      ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF2193b0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: onConfirm,
                        child: Text(confirmText),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showGPSDialog(BuildContext context) {
    _showCustomDialog(
      context: context,
      title: "Location Disabled",
      content: "Please turn on your device location (GPS) for local weather.",
      confirmText: "Settings",
      onConfirm: () async {
        Navigator.of(context).pop();
        await Geolocator.openLocationSettings();
        await Future.delayed(const Duration(seconds: 1));
        if (context.mounted) startAppFlow(context);
      },
    );
  }

  void _showPermissionDialog(BuildContext context) {
    _showCustomDialog(
      context: context,
      title: "Permission Required",
      content:
          "Location permission is needed. Please enable it in app settings.",
      confirmText: "App Settings",
      onConfirm: () async {
        Navigator.of(context).pop();
        await openAppSettings();
        await Future.delayed(const Duration(seconds: 1));
        if (context.mounted) startAppFlow(context);
      },
    );
  }

  void _showNoInternetDialog(BuildContext context) {
    _showCustomDialog(
      context: context,
      title: "No Internet",
      content: "Please check your data or Wi-Fi to get weather updates.",
      confirmText: "Retry",
      showCancel: false,
      onConfirm: () {
        Navigator.of(context).pop();
        startAppFlow(context);
      },
    );
  }
}
