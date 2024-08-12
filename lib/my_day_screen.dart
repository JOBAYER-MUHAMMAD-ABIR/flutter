import 'package:flutter/material.dart';

class MyDayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherData = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('My Day'),
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          children: [
            _buildOptionButton(context, Icons.videogame_asset, 'Game', weatherData),
            _buildOptionButton(context, Icons.restaurant_menu, 'Recipe', weatherData),
            _buildOptionButton(context, Icons.movie, 'Movie', weatherData),
            _buildOptionButton(context, Icons.book, 'Book', weatherData),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context, IconData icon, String label, Map weatherData) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/recommendation', arguments: {'type': label, 'weatherData': weatherData});
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black54,
        padding: EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.yellow, size: 50),
          SizedBox(height: 10),
          Text(label, style: TextStyle(color: Colors.yellow, fontSize: 20)),
        ],
      ),
    );
  }
}
