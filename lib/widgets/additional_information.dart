import 'package:flutter/material.dart';

class AdditionalInformation extends StatelessWidget {
  final String parameter;
  final IconData icon;
  final String value;
  const AdditionalInformation({
    super.key,
    required this.parameter,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon),
            SizedBox(height: 8),
            Text(
              parameter,
              style: TextStyle(
                fontSize: 14,
                color: const Color.fromARGB(255, 184, 183, 183),
              ),
            ),
            SizedBox(height: 8),
            Text(value),
          ],
        ),
      ),
    );
  }
}
