import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_app_weather/model/city_info.dart';

class CitiesRepository {
  Future<List<CityInfo>> FetchContentFromJsonFile(String value) async {
    final String response = await rootBundle.loadString(value);
    final data = await json.decode(response);
    List<CityInfo> cityList = [];
    data.forEach((v) {
      cityList.add(CityInfo.fromJson(v));
    });

    return cityList;
  }
}
