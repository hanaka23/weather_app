import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherApp {
  static const String apiKey =
      'a5bd9243b01a74b83b09ae1e217e9fbd'; // OpenWeatherMapのAPIキーを入れる
  static const String todayBaseUrl =
      'https://api.openweathermap.org/data/2.5/weather';
  static const String futureBaseUrl =
      'http://api.openweathermap.org/data/2.5/forecast';


  static Future<Map<String, dynamic>> getWeather(String cityName) async {
    final todayUrl = Uri.parse(
        '$todayBaseUrl?q=$cityName&appid=$apiKey&units=metric');
    final futureUrl = Uri.parse(
        '$futureBaseUrl?q=$cityName&appid=$apiKey&units=metric');

    // 両方のリクエストを並行して実行
    final todayResponse = await http.get(todayUrl);
    final futureResponse = await http.get(futureUrl);

    // 両方のレスポンスを確認
    if (todayResponse.statusCode == 200 && futureResponse.statusCode == 200) {
  final todayData = json.decode(todayResponse.body);
  final futureData = json.decode(futureResponse.body);

  // print('Today Data: $todayData');
  // print('Future Data: $futureData');
  print(todayData['main']['temp'].runtimeType);

  return {
    'today': todayData,
    'future': futureData,
  };
} else {
  // print('Today Response: ${todayResponse.body}');
  // print('Future Response: ${futureResponse.body}');
  throw Exception('Failed to load weather data');
}

  }
}
