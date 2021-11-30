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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: Colors.amber[300],
        contentPadding: EdgeInsets.all(8),
        leading: Hero(
            tag: "weather${item.id}",
            child: Image.network(
              item.weather?.icon ?? "",
              // color: Colors.yellow,
            )),
        title: Text(item.cityName ?? "City Name"),
        trailing:
            Text((item.mainInfo?.temp?.toString() ?? "0") + " $_degreeSymbol"),
        onTap: onTap,
      ),
    );
  }
}
