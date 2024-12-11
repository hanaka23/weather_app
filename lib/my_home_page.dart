import 'package:flutter/material.dart';
import 'package:weather/colors.dart';
import 'package:weather/weather_app.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String cityName = '';
  String weatherInfo = 'Enter a city name';
  String todayWeather = '';
  String todayTmp = '';

  Future<void> fetchWeather() async {
    try {
      final data = await WeatherApp.getWeather(cityName);
      final forecastList = data['future']['list'];

      // for (var 変数 in 配列)
      // Listなどに格納されている全てのデータを0から順に取得し、宣言した変数に代入させていく
      for (var forecast in forecastList) {
        final dateTime = forecast['dt_txt']; // 日時
        final temp = forecast['main']['temp']; // 温度
        final weatherDescription =
            forecast['weather'][0]['description']; // 天気の説明

        print(
            'DateTime: $dateTime, Temp: $temp°C, Weather: $weatherDescription');
      }

      setState(() {
        todayWeather = data['today']['main']['temp'];
        todayTmp = data['today']['weather'][0]['description'];
        weatherInfo = 'Temperature: $todayWeather°C\n'
            'Condition: $todayTmp';
      });
    } catch (e) {
      setState(() {
        weatherInfo = 'Error fetching weather data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onPressed: fetchWeather,
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 20),
            Text(weatherInfo, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
