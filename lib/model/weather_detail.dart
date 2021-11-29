class WeatherDetail {
  Coord? coordinates;
  List<Weather>? weather;
  String? base;
  Main? mainInfo;
  int? visibility;
  Wind? wind;
  Clouds? clouds;
  int? timeOfCalculation;
  Sys? sys;
  int? timezone;
  int? id;
  String? cityName;
  int? cod;

  WeatherDetail(
      {this.coordinates,
      this.weather,
      this.base,
      this.mainInfo,
      this.visibility,
      this.wind,
      this.clouds,
      this.timeOfCalculation,
      this.sys,
      this.timezone,
      this.id,
      this.cityName,
      this.cod});

  WeatherDetail.fromJson(Map<String, dynamic> json) {
    // print("json: $json");
    coordinates = json['coord'] != null ? Coord.fromJson(json['coord']) : null;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather?.add(Weather.fromJson(v));
      });
    }
    base = json['base'];
    mainInfo = json['main'] != null ? Main.fromJson(json['main']) : null;
    visibility = json['visibility'];
    wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;
    clouds = json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null;
    timeOfCalculation = json['dt'];
    sys = json['sys'] != null ? Sys.fromJson(json['sys']) : null;
    timezone = json['timezone'];
    id = json['id'];
    cityName = json['name'];
    cod = json['cod'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (coordinates != null) {
      data['coord'] = coordinates?.toJson();
    }
    if (weather != null) {
      data['weather'] = weather?.map((v) => v.toJson()).toList();
    }
    data['base'] = base;
    if (mainInfo != null) {
      data['main'] = mainInfo?.toJson();
    }
    data['visibility'] = visibility;
    if (wind != null) {
      data['wind'] = wind?.toJson();
    }
    if (clouds != null) {
      data['clouds'] = clouds?.toJson();
    }
    data['dt'] = timeOfCalculation;
    if (sys != null) {
      data['sys'] = sys?.toJson();
    }
    data['timezone'] = timezone;
    data['id'] = id;
    data['name'] = cityName;
    data['cod'] = cod;
    return data;
  }
}

class Coord {
  double? lon;
  double? lat;

  Coord({this.lon, this.lat});

  Coord.fromJson(Map<String, dynamic> json) {
    lon = json['lon'];
    lat = json['lat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lon'] = lon;
    data['lat'] = lat;
    return data;
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}

class Main {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  int? seaLevel;
  int? grndLevel;

  Main(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.humidity,
      this.seaLevel,
      this.grndLevel});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'].toDouble();
    feelsLike = json['feels_like'].toDouble();
    tempMin = json['temp_min'].toDouble();
    tempMax = json['temp_max'].toDouble();
    pressure = json['pressure'];
    humidity = json['humidity'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    data['sea_level'] = seaLevel;
    data['grnd_level'] = grndLevel;
    return data;
  }
}

class Wind {
  double? speed;
  int? deg;
  double? gust;

  Wind({this.speed, this.deg, this.gust});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    deg = json['deg'];
    gust = json['gust'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = deg;
    data['gust'] = gust;
    return data;
  }
}

class Clouds {
  int? percentage;

  Clouds({this.percentage});

  Clouds.fromJson(Map<String, dynamic> json) {
    percentage = json['all'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['all'] = percentage;
    return data;
  }
}

class Sys {
  String? country;
  int? sunrise;
  int? sunset;

  Sys({this.country, this.sunrise, this.sunset});

  Sys.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }
}
