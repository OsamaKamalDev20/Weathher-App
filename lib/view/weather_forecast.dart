import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:weather_forecast/services/weather_service.dart';

import '../colors/weather_colors.dart';

class WeatherForecastScreen extends StatefulWidget {
  final String city;
  WeatherForecastScreen({super.key, required this.city});

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  final WeatherServices _weatherServices = WeatherServices();
  List<dynamic>? _forecast;

  @override
  void initState() {
    super.initState();
    _fetchForecast();
  }

  Future<void> _fetchForecast() async {
    try {
      final forecastData =
          await _weatherServices.fetch7DayForecast(widget.city);
      setState(() {
        _forecast = forecastData['forecast']['forecastday'];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _forecast == null
            ? Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      darkBlue2,
                      primaryBlack,
                      secondaryBlack,
                      darkBlue,
                      accentBlue,
                    ],
                  ),
                ),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      darkBlue2,
                      primaryBlack,
                      secondaryBlack,
                      darkBlue,
                      accentBlue,
                    ],
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_rounded,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "3 Days Weather Forecast",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      FadeInRight(
                        delay: Duration(milliseconds: 2000),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "${widget.city} 3 days weather",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      FadeInRight(
                        delay: Duration(milliseconds: 2500),
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _forecast!.length,
                          itemBuilder: ((context, index) {
                            final day = _forecast![index];
                            String iconUrl =
                                "http:${day['day']['condition']['icon']}";
                            return Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                height: 130,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: darkBlue2,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  leading: Image.network(iconUrl),
                                  title: Text(
                                    "${day['date']}\n${day['day']['avgtemp_c'].round()}°C",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "${day['day']['condition']['text']}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  trailing: Text(
                                    "Max: ${day['day']['maxtemp_c'].round()}°C \nMin: ${day['day']['mintemp_c'].round()}°C",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
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
