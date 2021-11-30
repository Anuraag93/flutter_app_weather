import 'package:flutter/material.dart';
import 'package:flutter_app_weather/model/apis/api_response.dart';
import 'package:flutter_app_weather/model/weather_detail.dart';
import 'package:flutter_app_weather/view_model/weather_view_model.dart';
import 'package:provider/provider.dart';

class WeatherDetailScreen extends StatefulWidget {
  final WeatherDetail info;
  const WeatherDetailScreen({Key? key, required this.info}) : super(key: key);

  @override
  _WeatherDetailScreenState createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  late WeatherDetail _info;
  @override
  void initState() {
    _info = widget.info;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ApiResponse apiResponse = Provider.of<WeatherViewModel>(context).response;

    return Scaffold(appBar: AppBar(), body: _scaffoldBody(apiResponse));
  }

  Widget _scaffoldBody(ApiResponse apiResponse) {
    var cityWeatherList = apiResponse.data as List<WeatherDetail>?;
    switch (apiResponse.status) {
      case Status.LOADING:
        return Center(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            CircularProgressIndicator(),
            SizedBox(),
            Text(apiResponse.message.toString()),
          ],
        ));
      case Status.COMPLETED:
        var temp =
            cityWeatherList?.where((v) => v.id == widget.info.id).toList();
        if (temp != null && temp.isNotEmpty) {
          print("New Update: *********");
          _info = temp[0];
        }
        return _detailWidget();
      case Status.ERROR:
        return Center(
          child: Text('Please try again latter!!!'),
        );
      case Status.INITIAL:
      default:
        return Center(
          child: Text("No Information available."),
        );
    }
  }

  Widget _detailWidget() {
    return SingleChildScrollView(
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
    );
  }
}
