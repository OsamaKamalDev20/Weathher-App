import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_forecast/colors/weather_colors.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_forecast/screens/weather_onboarding_screen.dart';

class WeatherSplashScreen extends StatefulWidget {
  const WeatherSplashScreen({super.key});

  @override
  State<WeatherSplashScreen> createState() => _WeatherSplashScreenState();
}

class _WeatherSplashScreenState extends State<WeatherSplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 6), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => WeatherOnBoardingScreen()),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/images/splash_screen.json",
                repeat: true,
                reverse: true,
                animate: true,
              ),
              SizedBox(height: 10),
              Text(
                "Welcome to Weather \nTracker App",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
