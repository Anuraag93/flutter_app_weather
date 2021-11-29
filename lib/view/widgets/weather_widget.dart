import 'package:flutter/material.dart';
import 'package:flutter_app_weather/model/weather_detail.dart';

class WeatherWidget extends StatelessWidget {
  final WeatherDetail item;
  final VoidCallback onTap;
  final _degreeSymbol = " \u2103";

  WeatherWidget({Key? key, required this.item, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.cityName ?? "City Name"),
      trailing:
          Text((item.mainInfo?.temp?.toString() ?? "0") + " $_degreeSymbol"),
      onTap: onTap,
    );
  }
}
