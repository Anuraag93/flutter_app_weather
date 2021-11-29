abstract class BaseService {
  final String weatherBaseUrl =
      "https://api.openweathermap.org/data/2.5/weather";

  Future<dynamic> getResponse(String url);
}
