import 'dart:convert';
import 'dart:io';

import 'package:flutter_app_weather/model/apis/app_exception.dart';
import 'package:flutter_app_weather/model/services/base_service.dart';
import 'package:http/http.dart' as http;

class WeatherService extends BaseService {
  // api.openweathermap.org/data/2.5/weather?appid={API key}&id={city id}
  final String _apiKey = "19b95963245b23cfa4c88f864bb6c596";

  @override
  Future getResponse(String url) async {
    dynamic jsonResponse;
    try {
      var otherParams = "?units=metric&id=" + url + "&appid=" + _apiKey;
      var parsedUrl = Uri.parse(weatherBaseUrl + otherParams);
      final response = await http.get(parsedUrl);
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return jsonResponse;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}
