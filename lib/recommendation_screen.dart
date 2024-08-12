import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class RecommendationScreen extends StatefulWidget {
  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  var recommendations;
  String type = '';
  Map<String, dynamic> weatherData = {};
  GenerativeModel? model;
  bool isModelInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeModel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve arguments from the route
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    if (args != null) {
      type = args['type'] ?? '';
      weatherData = args['weatherData'] ?? {};
      // Fetch recommendations only if the model is initialized
      if (isModelInitialized) {
        _fetchRecommendations();
      }
    }
  }

  void _initializeModel() async {
    final apiKey = 'AIzaSyAqcwuzfW1O0C1X2BudxuTrGbqJEh7qsfQ'; // Replace with your actual API key
    try {
      model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );
      print('Model initialized successfully');
      setState(() {
        isModelInitialized = true;
      });
      // Fetch recommendations after model initialization and data retrieval
      _fetchRecommendations();
    } catch (error) {
      print('Error initializing model: $error');
    }
  }

  void _fetchRecommendations() async {
    if (model == null || weatherData.isEmpty) return;

    final prompt = "Recommend things to do based on the weather data (type: $type).\n"
        "Weather data: ${weatherData.toString()}";

    final content = [Content.text(prompt)];

    try {
      final response = await model!.generateContent(content);
      setState(() {
        recommendations = response.text?.split('\n'); // Adjust based on actual response structure
      });
    } catch (error) {
      print('Error fetching recommendations: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('$type Recommendations'),
        backgroundColor: Colors.yellow,
      ),
      body: recommendations == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: recommendations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recommendations[index],
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
