import 'package:flutter/material.dart';
import 'package:weather/colors.dart';
import 'package:weather/home.dart';
import 'package:weather/weather_app.dart';

class InputPrefecturePage extends StatefulWidget {
  const InputPrefecturePage({super.key});

  @override
  State<InputPrefecturePage> createState() => _InputPrefecturePageState();
}

class _InputPrefecturePageState extends State<InputPrefecturePage> {
  String cityName = '';
  String weatherInfo = 'Enter a city name';
  String todayWeather = '';
  num todayTmp = 0;

  Future<void> fetchWeather() async {
    try {
      final data = await WeatherApp.getWeather(cityName);

      setState(() {
        todayWeather = data['today']['weather'][0]['description'];
        todayTmp = (data['today']['main']['temp']).round();
        weatherInfo = '$todayTmp';
      });

      // 天気データ取得成功時に画面遷移
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(weatherInfo),
        ),
      );
    } catch (e) {
      setState(() {
        weatherInfo = 'Error fetching weather data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: MyColors.blue,
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Enter City Name'),
              onChanged: (value) {
                cityName = value;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (cityName.isNotEmpty) {
                  await fetchWeather();
                } else {
                  // 入力が空の場合の警告メッセージ
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a city name'),
                    ),
                  );
                }
              },
              child: const Text('Get Weather'),
            ),
          ],
        ),
      ),
    );
  }
}
