import 'package:flutter/material.dart';
import 'package:weather/colors.dart';
import 'package:weather/weatherIcon.dart';

class MyHomePage extends StatefulWidget {
  final String tmp;
  final String weatherDescription;

  const MyHomePage(
      {Key? key, required this.tmp, required this.weatherDescription})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    debugPrint('weatherDescription: ${widget.weatherDescription}');
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // 中央揃え
              crossAxisAlignment: CrossAxisAlignment.center, // 縦方向で中央揃え
              children: [
                WeatherIcon(weatherDescription: widget.weatherDescription),
                const SizedBox(width: 10),
                Container(
                  height: 160, // 画像と同じ高さ
                  alignment: Alignment.center, // テキストを中央揃え
                  child: Text(
                    widget.tmp, // MyHomePageのプロパティtmpはwidget.tmpでアクセス
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 64,
                      height: 1,
                    ),
                  ),
                ),



                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
