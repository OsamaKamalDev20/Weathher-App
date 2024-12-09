import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherServices {
  final String apiKey = '14ff0b16859648a68f691602242303';
  final String forecastBaseUrl = 'http://api.weatherapi.com/v1/forecast.json';
  final String searchBaseUrl = 'http://api.weatherapi.com/v1/search.json';

  Future<Map<String, dynamic>> fetchCurrentWeather(String city) async {
    final url = '$forecastBaseUrl?key=$apiKey&q=$city&days=1&aqi=no&alerts=no';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load weather data");
    }
  }

  Future<Map<String, dynamic>> fetch7DayForecast(String city) async {
    final url = '$forecastBaseUrl?key=$apiKey&q=$city&days=7&aqi=no&alerts=no';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load forecast data");
    }
  }

  Future<List<dynamic>?> fetchCitySuggestion(String query) async {
    final url = '$searchBaseUrl?key=$apiKey&q=$query';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
