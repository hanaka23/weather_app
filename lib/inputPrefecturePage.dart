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
  List futureWeather = [];
  List futureTmp = [];
  List tmp = [];
  List dt = [];

  Future<void> fetchWeather() async {
    try {
      final data = await WeatherApp.getWeather(cityName);

      setState(() {
        todayWeather = data['today']['weather'][0]['main'];
        todayTmp = (data['today']['main']['temp']).round();
        weatherInfo = '$todayTmp';
        futureTmp = [
          (data['future']['list'][0]['main']['temp']).round(),
          (data['future']['list'][7]['main']['temp']).round(),
          (data['future']['list'][15]['main']['temp']).round(),
          (data['future']['list'][23]['main']['temp']).round(),
          (data['future']['list'][31]['main']['temp']).round(),
          (data['future']['list'][39]['main']['temp']).round(),
        ];
        // 3hour tmp
        tmp = [
          for (int i = 1; i < 39; i++)
            (data['future']['list'][i]['main']['temp']).round()
        ];
        // 3hour time
        dt = [
          for (int i = 1; i < 39; i++)
            (data['future']['list'][i]['dt_txt'])
        ];
        // 指定されたインデックスの天気データをリストに格納
        futureWeather = [
          data['future']['list'][0]['weather'][0]['main'],
          data['future']['list'][7]['weather'][0]['main'],
          data['future']['list'][15]['weather'][0]['main'],
          data['future']['list'][23]['weather'][0]['main'],
          data['future']['list'][31]['weather'][0]['main'],
          data['future']['list'][39]['weather'][0]['main'],
        ];
      });
      // print('future weather = $futureWeather');
      // print('today weather = $data[today]');
      print('tmp list = $dt');

      // print('futureTmp = $futureTmp');
      // 天気データ取得成功時に画面遷移（todayWeatherも渡す）
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            tmp: weatherInfo, // 気温データ
            weatherDescription: todayWeather, // 天気の説明
          ),
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
