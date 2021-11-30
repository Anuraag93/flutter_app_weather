import 'package:flutter/material.dart';
import 'package:flutter_app_weather/model/apis/api_response.dart';
import 'package:flutter_app_weather/model/city_info.dart';

import 'package:flutter_app_weather/model/weather_detail.dart';
import 'package:flutter_app_weather/model/repositories/weather_repository.dart';

class WeatherViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty List');

  ApiResponse get response {
    return _apiResponse;
  }

  /// Call the weather service and gets the requested weather data of
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

  /// Call the weather service and gets the requested weather data of
  /// a list of cities.
  Future<void> fetchWeatherList(List<String> cities,
      {bool fromInit = false}) async {
    _apiResponse = ApiResponse.loading('Fetching Weather Updates');
    if (!fromInit) notifyListeners();
    try {
      List<WeatherDetail> weatherList = [];
      for (var value in cities) {
        WeatherDetail w =
            await WeatherRepository().fetchWeatherViaCityId(value);

        weatherList.add(w);
        print("Fetched city " + w.cityName.toString());
      }
      _apiResponse = ApiResponse.completed(weatherList);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }
}
