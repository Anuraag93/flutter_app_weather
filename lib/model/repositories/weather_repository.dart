import 'package:flutter_app_weather/model/services/weather_service.dart';
import 'package:flutter_app_weather/model/weather_detail.dart';

import '../services/base_service.dart';

class WeatherRepository {
  final BaseService _weatherService = WeatherService();

  Future<WeatherDetail> fetchWeatherViaCityId(String value) async {
    // print("city Id: $value");
    dynamic response = await _weatherService.getResponse(value);

    // final dynamic jsonData = response as List;
    final dynamic jsonData = response as Map;
    WeatherDetail weatherInfo = WeatherDetail.fromJson(jsonData);
    return weatherInfo;
  }
}
