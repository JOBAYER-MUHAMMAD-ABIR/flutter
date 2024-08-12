import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationInputScreen extends StatefulWidget {
  @override
  _LocationInputScreenState createState() => _LocationInputScreenState();
}

class _LocationInputScreenState extends State<LocationInputScreen> {
  TextEditingController _locationController = TextEditingController();

  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _locationController.text =
      '${position.latitude}, ${position.longitude}';
    });

    Navigator.pushNamed(context, '/weather',
        arguments: {
          'latitude': position.latitude,
          'longitude': position.longitude,
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  hintText: 'Your present location',
                  border: OutlineInputBorder(),
                ),
                enabled: false,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getCurrentLocation,
                child: Text(
                  'Use Current Location',
                  style: TextStyle(color: Colors.black), // Change text color to white
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.yellow, // Text color of the button
                  minimumSize: Size(200, 60), // Increase button size (width x height)
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0), // Adjust padding
                  textStyle: TextStyle(fontSize: 18), // Increase text size
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
