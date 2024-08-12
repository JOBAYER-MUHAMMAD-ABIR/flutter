import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'location_input_screen.dart';
import 'weather_info_screen.dart';
import 'my_day_screen.dart';
import 'recommendation_screen.dart';

void main() {
  runApp(GeminiWeatherApp());
}

class GeminiWeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GeminiWeather',
      theme: ThemeData(
        primaryColor: Colors.yellow,
        hintColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/location': (context) => LocationInputScreen(),
        '/weather': (context) => WeatherInfoScreen(),
        '/my_day': (context) => MyDayScreen(),
        '/recommendation': (context) => RecommendationScreen(),
      },
    );
  }
}
