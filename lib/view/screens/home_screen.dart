import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_weather/model/apis/api_response.dart';
import 'package:flutter_app_weather/model/weather_detail.dart';
import 'package:flutter_app_weather/view/view.dart';
import 'package:flutter_app_weather/view/widgets/progress_loader.dart';
import 'package:flutter_app_weather/view/widgets/weather_widget.dart';
import 'package:flutter_app_weather/view_model/weather_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Set<String> _cities = {"2147714", "4163971", "2174003"};
  List<WeatherDetail> _cityWeathers = [];
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    print("InitState of homescreen ********");

    Provider.of<WeatherViewModel>(context, listen: false)
        .fetchWeatherList(_cities.toList(), fromInit: true);

    Provider.of<WeatherViewModel>(context, listen: false).fetchCityList();

    _timer = Timer.periodic(Duration(seconds: 60), (Timer t) {
      print("Periodic Update ${t.tick}");
      Provider.of<WeatherViewModel>(context, listen: false)
          .fetchWeatherList(_cities.toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    ApiResponse apiResponse = Provider.of<WeatherViewModel>(context).response;
    print("s: " + apiResponse.status.toString());
    print("message: " + apiResponse.message.toString());

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            var id = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CitySearchScreen(
                      cityList:
                          Provider.of<WeatherViewModel>(context).cityList ??
                              [])),
            );
            if (id != null) {
              print("city Id add: $id");
              //add to the city list
              _cities.add(id.toString());
              Provider.of<WeatherViewModel>(context, listen: false)
                  .fetchWeatherList(_cities.toList());
            }
          }),
      body: _getWeatherWidget(context, apiResponse),
    );
  }

  Widget _getWeatherWidget(BuildContext context, ApiResponse apiResponse) {
    var cityWeatherList = apiResponse.data as List<WeatherDetail>?;
    switch (apiResponse.status) {
      case Status.LOADING:
        return ProgressLoader(message: apiResponse.message.toString());
      case Status.COMPLETED:
        final size = MediaQuery.of(context).size;
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

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
