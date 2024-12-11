import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherApp {
  static const String apiKey = 'a5bd9243b01a74b83b09ae1e217e9fbd'; // OpenWeatherMapのAPIキーを入れる
  static const String todayBaseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const String futureBaseUrl = 'http://api.openweathermap.org/data/2.5/forecast';

  static Future<Map<String, dynamic>> getWeather(String cityName) async {
    final todayUrl = Uri.parse('$todayBaseUrl?q=$cityName&appid=$apiKey&lang=ja&units=metric');
    final futureUrl = Uri.parse('$futureBaseUrl?q=$cityName&appid=$apiKey&lang=ja&units=metric');

    // 両方のリクエストを並行して実行
    final todayResponse = await http.get(todayUrl);
    final futureResponse = await http.get(futureUrl);

    // 両方のレスポンスを確認
    if (todayResponse.statusCode == 200 && futureResponse.statusCode == 200) {
      final todayData = json.decode(todayResponse.body);
      final futureData = json.decode(futureResponse.body);
      

      // 2つのデータをまとめて返す
      return {
        'today': todayData,
        'future': futureData,
      };
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
