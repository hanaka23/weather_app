import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final String weatherDescription;

  const WeatherIcon({Key? key, required this.weatherDescription}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 天気の説明に応じてアイコンを切り替え
    String iconPath;
    if (weatherDescription == 'clear sky') {
      iconPath = 'assets/images/clear.png'; // 晴れのアイコン
    } else if (weatherDescription == 'cloud') {
      iconPath = 'assets/images/cloud.png'; // 曇りのアイコン
    } else {
      iconPath = 'assets/images/default.png'; // その他のデフォルトアイコン
    }

    return Image.asset(
      iconPath,
      height: 160,
      width: 160,
    );
  }
}
