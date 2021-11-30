import 'package:flutter/material.dart';
import 'package:flutter_app_weather/model/apis/api_response.dart';
import 'package:flutter_app_weather/model/weather_detail.dart';
import 'package:flutter_app_weather/view/widgets/grid_item_widget.dart';
import 'package:flutter_app_weather/view/widgets/progress_loader.dart';
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
  final _degreeSymbol = "°";
  @override
  void initState() {
    _info = widget.info;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ApiResponse apiResponse = Provider.of<WeatherViewModel>(context).response;

    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                _getAssetImage(_info.weather!.main),
              ),
            ),
          ),
        ),
        Container(
          color: Colors.white30,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: _scaffoldBody(apiResponse),
        ),
        IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back)),
      ],
    )));
  }

  Widget _scaffoldBody(ApiResponse apiResponse) {
    var cityWeatherList = apiResponse.data as List<WeatherDetail>?;
    switch (apiResponse.status) {
      case Status.LOADING:
        return ProgressLoader(message: apiResponse.message.toString());
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
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(height: 80),
              // Text("Name"),
              Center(
                child: Hero(
                    tag: "weather${_info.id}",
                    child: Image.network(
                      _info.weather?.icon ?? "",
                      // width: 150,
                      // height: 150,
                      // color: Colors.yellow,
                    )),
              ),
              Center(
                child: Text(
                  _info.cityName!,
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Center(
                  child: Text(
                (_info.mainInfo?.temp!.round().toString() ?? "") +
                    _degreeSymbol,
                style: TextStyle(fontSize: 80),
              )),
              Center(
                  child: Text(
                _info.weather!.main!,
                style: TextStyle(fontSize: 20),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "L: ${_info.mainInfo!.tempMin?.round().toString()}$_degreeSymbol",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "H: ${_info.mainInfo!.tempMax?.round().toString()}$_degreeSymbol",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              ListTile(
                title: Text("Summary"),
                subtitle:
                    Text("Weather condition is ${_info.weather!.description!}"),
              ),
            ],
          ),
        ),
        SliverGrid.extent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            GridItemWidget(
                title: "FEELS LIKE",
                value:
                    " ${_info.mainInfo!.feelsLike?.round().toString()}$_degreeSymbol"),
            GridItemWidget(
                title: "HUMIDITY",
                value: " ${_info.mainInfo!.humidity?.round().toString()}%"),
            GridItemWidget(
                title: "Atmospheric Pressure",
                value: " ${_info.mainInfo!.pressure?.round().toString()}hPa"),
            GridItemWidget(
                title: "WIND",
                value:
                    " Speed: ${_info.wind!.speed?.round().toString()}m/s \n Direction: ${_info.wind!.speed?.round().toString()}$_degreeSymbol"),
            GridItemWidget(
                title: "CLOUDINESS",
                value: " ${_info.clouds!.percentage?.round().toString()}%"),
            GridItemWidget(
                title: "DATE & TIME",
                value: " ${_info.timeOfCalculation.toString()}"),
          ],
        )
      ],
    );
  }

  String _getAssetImage(String? type) {
    switch (type) {
      case "Clouds":
        return "assets/images/cloud.jpg";
      case "Rain":
        return "assets/images/rain.jpg";
      case "Snow":
        return "assets/images/snow.jpg";
      case "Clear":
        return "assets/images/clear.jpg";

      default:
        return "assets/images/default.jpg";
    }
  }
}
