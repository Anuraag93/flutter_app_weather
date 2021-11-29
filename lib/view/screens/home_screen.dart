import 'package:flutter/material.dart';
import 'package:flutter_app_weather/model/apis/api_response.dart';
import 'package:flutter_app_weather/model/weather_detail.dart';
import 'package:flutter_app_weather/view_model/weather_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Weather data for melbourne => 4163971
    //Sydney => 2147714,
    //Brisbane => 2174003
    Provider.of<WeatherViewModel>(context, listen: false)
        .fetchWeatherData("2174003");
  }

  @override
  Widget build(BuildContext context) {
    ApiResponse apiResponse = Provider.of<WeatherViewModel>(context).response;
    print("s: " + apiResponse.status.toString());
    print("message: " + apiResponse.message.toString());
    if (apiResponse.status == Status.COMPLETED) {
      WeatherDetail data = apiResponse.data;
      print(data.cityName);
    }

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.green,
        alignment: Alignment.center,
        child: Text("home screen"),
      ),
    );
  }
}
