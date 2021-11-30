import 'package:flutter/material.dart';
import 'package:flutter_app_weather/model/city_info.dart';
import 'package:flutter_app_weather/model/repositories/cities_repository.dart';

class SearchCitiesViewModel with ChangeNotifier {
  List<CityInfo>? _cityList;
  List<CityInfo>? _allCityList;
  String _addedCityId = "";

  String get addedCityId {
    return _addedCityId;
  }

  List<CityInfo>? get cityList {
    return _cityList;
  }

  /// Read cities info once from a json file.
  Future<void> fetchCityList() async {
    const String jsonLocation = "assets/city_list.json";
    try {
      _allCityList =
          await CitiesRepository().FetchContentFromJsonFile(jsonLocation);
      _allCityList?.sort((a, b) => a.name!.compareTo(b.name!));
      _cityList = _allCityList ?? [];
    } catch (e) {
      _cityList = [];
      print(e);
    }
    notifyListeners();
  }

  void runFilter(String keyword) {
    if (keyword.isEmpty) {
      // if the search field is empty or with white spaces, we will display complete city list.
      _cityList = _allCityList!;
    } else {
      _cityList = _allCityList!
          .where((city) =>
              city.name!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }

    notifyListeners();
  }

  Future<void> addSearchedCity(String value) async {
    _addedCityId = value;

    _cityList = _allCityList!;
    notifyListeners();
  }
}
