import 'dart:convert';
import 'package:app/Weather.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '44cc8d8302267f88e014c6d84b7f0a93';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> fetchWeather(String city) async {
    final url = Uri.parse('$baseUrl?q=$city&units=metric&appid=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
