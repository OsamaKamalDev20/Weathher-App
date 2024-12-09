import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:weather_forecast/colors/weather_colors.dart';
import 'package:weather_forecast/services/weather_service.dart';
import 'package:weather_forecast/view/weather_forecast.dart';
import 'package:weather_forecast/widgets/weather_details.dart';

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  final WeatherServices _weatherServices = WeatherServices();
  String _city = "Karachi";
  Map<String, dynamic>? _currentWeather;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final weatherData = await _weatherServices.fetchCurrentWeather(_city);
      setState(() {
        _currentWeather = weatherData;
      });
    } catch (e) {
      print(e);
    }
  }

  void _showCitySelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter City Name"),
          content: TypeAheadField(
            suggestionsCallback: (pattern) async {
              return await _weatherServices.fetchCitySuggestion(pattern);
            },
            builder: (context, controller, focusNode) {
              return TextField(
                controller: controller,
                focusNode: focusNode,
                autofocus: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Enter City"),
              );
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion['name']),
              );
            },
            onSelected: (city) {
              setState(() {
                _city = city['name'];
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _fetchWeather();
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentWeather == null
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
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: FadeInRight(
                  delay: Duration(milliseconds: 2000),
                  child: ListView(
                    children: [
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    _city,
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/images/pinLocation.png",
                                    height: 25,
                                    width: 25,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on_rounded,
                                    size: 16,
                                    color: Colors.white54,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    _currentWeather!['location']['country'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _showCitySelectionDialog();
                                },
                                icon: Icon(
                                  Icons.location_city_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              Icon(
                                Icons.more_vert,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        "${_city} is located in ${_currentWeather!['location']['country']} in the province of ${_currentWeather!['location']['region']} with latitude around ${_currentWeather!['location']['lat'].toStringAsFixed(2)}° and longitude around ${_currentWeather!['location']['lon'].toStringAsFixed(2)}°.",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white60,
                        ),
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: Column(
                          children: [
                            Image.network(
                              "http:${_currentWeather!['current']['condition']['icon']}",
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              "${_currentWeather!['current']['temp_c'].round()}°C",
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${_currentWeather!['current']['condition']['text']}",
                              style: TextStyle(
                                fontSize: 34,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: darkBlue2,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/maxTemp.png",
                                        height: 30,
                                        width: 30,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "${_currentWeather!['forecast']['forecastday'][0]['day']['maxtemp_c'].round()}°C",
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: darkBlue2,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/minTemp.png",
                                        height: 30,
                                        width: 30,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "${_currentWeather!['forecast']['forecastday'][0]['day']['mintemp_c'].round()}°C",
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Weather Details",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WeatherDetails(
                            image: "assets/images/feelsLike.png",
                            label: 'Feels Like',
                            value:
                                "${_currentWeather!['current']['feelslike_c'].round()}°C",
                          ),
                          WeatherDetails(
                            image: "assets/images/windDirection.png",
                            label: 'Wind Direction',
                            value:
                                "${_currentWeather!['current']['wind_dir']} wind",
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WeatherDetails(
                            image: "assets/images/humidity.png",
                            label: 'Humidity',
                            value:
                                "${_currentWeather!['current']['humidity']}%",
                          ),
                          WeatherDetails(
                            image: "assets/images/windSpeed.png",
                            label: 'Wind Speed',
                            value:
                                "${_currentWeather!['current']['wind_kph'].round()} km/h",
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WeatherDetails(
                            image: "assets/images/visibility.png",
                            label: 'Visibility',
                            value:
                                "${_currentWeather!['current']['vis_km']} km",
                          ),
                          WeatherDetails(
                            image: "assets/images/airPressure.png",
                            label: 'Air Pressure',
                            value:
                                "${_currentWeather!['current']['pressure_mb'].round()} hPa",
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WeatherDetails(
                            image: "assets/images/sunrise.png",
                            label: 'Sunrise',
                            value:
                                "${_currentWeather!['forecast']['forecastday'][0]['astro']['sunrise']}",
                          ),
                          WeatherDetails(
                            image: "assets/images/sunset.png",
                            label: 'Sunrise',
                            value:
                                "${_currentWeather!['forecast']['forecastday'][0]['astro']['sunset']}",
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: lightBlue,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) =>
                                    WeatherForecastScreen(city: _city)),
                              ),
                            );
                          },
                          child: Text(
                            "Next 7 Days Forecast",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
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
