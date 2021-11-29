import 'package:flutter/material.dart';
import 'package:flutter_app_weather/model/apis/api_response.dart';
import 'package:flutter_app_weather/model/weather_detail.dart';
import 'package:flutter_app_weather/view/view.dart';
import 'package:flutter_app_weather/view/widgets/weather_widget.dart';
import 'package:flutter_app_weather/view_model/weather_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> cities = ["2147714", "4163971", "2174003"];
  List<WeatherDetail> cityWeathers = [];
  @override
  void initState() {
    super.initState();
    // Weather data for melbourne => 4163971
    //Sydney => 2147714,
    //Brisbane => 2174003
    // Provider.of<WeatherViewModel>(context, listen: false)
    //     .fetchWeatherData("2174003");
    Provider.of<WeatherViewModel>(context, listen: false)
        .fetchWeatherList(cities);
  }

  @override
  Widget build(BuildContext context) {
    ApiResponse apiResponse = Provider.of<WeatherViewModel>(context).response;
    print("s: " + apiResponse.status.toString());
    print("message: " + apiResponse.message.toString());

    return Scaffold(
      appBar: AppBar(),
      body: _getWeatherWidget(context, apiResponse),
    );
  }

  Widget _getWeatherWidget(BuildContext context, ApiResponse apiResponse) {
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
        return ListView.builder(
            itemCount: cityWeatherList?.length ?? 0,
            itemBuilder: (context, index) => WeatherWidget(
                  item: cityWeatherList![index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WeatherDetailScreen(
                              info: cityWeatherList[index])),
                    );
                  },
                ));
      case Status.ERROR:
        return Center(
          child: Text('Please try again latter!!!'),
        );
      case Status.INITIAL:
      default:
        return Center(
          child: Text("The list is empty. Please add more cities."),
        );
    }
  }
}
