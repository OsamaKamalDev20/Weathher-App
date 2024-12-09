// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:weather_forecast/colors/weather_colors.dart';

class WeatherDetails extends StatelessWidget {
  String label;
  dynamic value;
  String image;
  WeatherDetails({
    super.key,
    required this.image,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        color: darkBlue2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Image.asset(
            image,
            height: 40,
            width: 45,
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value is String ? value : value.toString(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
