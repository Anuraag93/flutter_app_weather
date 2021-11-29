import 'package:flutter/material.dart';
import 'package:flutter_app_weather/model/apis/api_response.dart';
import 'package:flutter_app_weather/model/weather_detail.dart';
import 'package:flutter_app_weather/model/weather_repository.dart';

class WeatherViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty List');

  Weather? _weather;

  ApiResponse get response {
    return _apiResponse;
  }

  Weather? get weather {
    return _weather;
  }

  /// Call the weather service and gets the data of requested weather data of
  /// a city.
  Future<void> fetchWeatherData(String value) async {
    _apiResponse = ApiResponse.loading('Fetching Weather data');
    notifyListeners();
    try {
      WeatherDetail weather =
          await WeatherRepository().fetchWeatherViaCityId(value);
      _apiResponse = ApiResponse.completed(weather);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }

  Future<void> fetchWeatherList(List<String> cities) async {
    _apiResponse = ApiResponse.loading('Fetching Weather List');
    // notifyListeners();
    try {
      List<WeatherDetail> weatherList = [];
      for (var value in cities) {
        WeatherDetail w =
            await WeatherRepository().fetchWeatherViaCityId(value);
        weatherList.add(w);
      }
      _apiResponse = ApiResponse.completed(weatherList);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }
}
