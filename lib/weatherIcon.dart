import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final String weatherDescription;

  const WeatherIcon({Key? key, required this.weatherDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    String iconPath;
    if (weatherDescription == 'Clear') {
      iconPath = 'assets/images/clear.png'; 
    } else if (weatherDescription == 'Clouds') {
      iconPath = 'assets/images/clouds.png'; 
    } else if (weatherDescription == 'Rain') {
      iconPath = 'assets/images/rain.png'; 
    } else if (weatherDescription == 'Snow') {
      iconPath = 'assets/images/snow.png'; 
    } else if (weatherDescription == 'Thunderstorm') {
      iconPath = 'assets/images/thunderstorm.png'; 
    } else if (weatherDescription == 'Drizzle') {
      iconPath = 'assets/images/drizzle.png'; 
    } else {
      iconPath = 'null';
    }

    return Image.asset(
      iconPath,
      height: 160,
      width: 160,
    );
  }
}
