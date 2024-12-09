import 'package:flutter/material.dart';
import 'package:weather_forecast/splash_screen.dart';
// import 'package:weather_forecast/splash_screen.dart';
// import 'view/weather_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        primarySwatch: Colors.blue,
      ),
      home: WeatherSplashScreen(),
    );
  }
}
