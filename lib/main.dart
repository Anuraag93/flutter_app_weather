import 'package:flutter/material.dart';
import 'package:flutter_app_weather/view/view.dart';
import 'package:flutter_app_weather/view_model/search_cities_view_model.dart';
import 'package:flutter_app_weather/view_model/weather_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: WeatherViewModel()),
        ChangeNotifierProvider.value(value: SearchCitiesViewModel()),
      ],
      child: MaterialApp(
        title: 'Weather Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
