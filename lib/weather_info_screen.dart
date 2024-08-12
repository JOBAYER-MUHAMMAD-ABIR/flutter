import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherInfoScreen extends StatefulWidget {
  @override
  _WeatherInfoScreenState createState() => _WeatherInfoScreenState();
}

class _WeatherInfoScreenState extends State<WeatherInfoScreen> {
  var weatherData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    _fetchWeatherData(args['latitude'], args['longitude']);
  }

  void _fetchWeatherData(double lat, double lon) async {
    final apiKey = '73ab8294072791dd6bcb488e5d1a716c';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        weatherData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Weather Information'),
        backgroundColor: Colors.yellow,
      ),
      body: weatherData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildWeatherBox(
                icon: Icons.location_on,
                label: 'Location',
                value: '${weatherData['name']}, ${weatherData['sys']['country']}',
              ),
              _buildWeatherBox(
                icon: Icons.thermostat_outlined,
                label: 'Temperature',
                value: '${weatherData['main']['temp']} °C',
              ),
              _buildWeatherBox(
                icon: Icons.air,
                label: 'Air Speed',
                value: '${weatherData['wind']['speed']} m/s',
              ),
              _buildWeatherBox(
                icon: Icons.speed,
                label: 'Pressure',
                value: '${weatherData['main']['pressure']} hPa',
              ),
              _buildWeatherBox(
                icon: Icons.water_drop,
                label: 'Humidity',
                value: '${weatherData['main']['humidity']} %',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/my_day', arguments: weatherData);
                },
                child: Text(
                  'My Day',
                  style: TextStyle(color: Colors.black), // Change text color to white
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow, // Background color of the button
                  minimumSize: Size(200, 60), // Optional: Adjust size of the button
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0), // Optional: Adjust padding
                  textStyle: TextStyle(fontSize: 18), // Optional: Adjust text size
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherBox({required IconData icon, required String label, required String value}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.yellow, size: 40),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  value,
                  style: TextStyle(color: Colors.yellow, fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
