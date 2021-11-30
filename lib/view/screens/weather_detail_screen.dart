import 'package:flutter/material.dart';
import 'package:flutter_app_weather/model/weather_detail.dart';

class WeatherDetailScreen extends StatefulWidget {
  final WeatherDetail info;
  const WeatherDetailScreen({Key? key, required this.info}) : super(key: key);

  @override
  _WeatherDetailScreenState createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  @override
  Widget build(BuildContext context) {
    WeatherDetail _info = widget.info;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Name"),
            Text(_info.cityName!),
            Text("Weather Summary"),
            Text(_info.weather![0].main!),
            Text(_info.weather![0].description!),
            Text("Main"),
            Text(_info.mainInfo!.temp.toString()),
            Text(_info.mainInfo!.feelsLike.toString()),
            Text(_info.mainInfo!.tempMin.toString()),
            Text(_info.mainInfo!.tempMin.toString()),
            Text(_info.mainInfo!.pressure.toString()),
            Text(_info.mainInfo!.humidity.toString()),
            Text(_info.mainInfo!.grndLevel.toString()),
            Text(_info.mainInfo!.seaLevel.toString()),
            Text("Wind"),
            Text(_info.wind!.speed.toString()),
            Text(_info.wind!.deg.toString()),
            Text(_info.wind!.gust.toString()),
            Text(_info.visibility.toString()),
            Text("Cloud"),
            Text(_info.clouds!.percentage.toString() + " %"),
            Text("sys"),
            Text(_info.sys!.country.toString()),
            Text(_info.sys!.sunrise.toString()),
            Text(_info.sys!.sunset.toString()),
            Text("time"),
            Text(_info.timeOfCalculation.toString()),
            Text(_info.timezone.toString()),
          ],
        ),
      ),
    );
  }
}
