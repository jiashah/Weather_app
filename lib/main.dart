import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'remove debug banner';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
        scaffoldBackgroundColor:
            Colors.white, 
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Center(
          child: Text(
            'Android Club',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0, 
              fontWeight: FontWeight.bold, 
            ),
          ),
        ),
        backgroundColor: Colors.blue, 
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.notifications), 
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Notifications'),
                      content: Text('No notifications'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                'Jia Shah',
                style: TextStyle(
                  fontSize: 20,
                ),
              ), 
              accountEmail: null, 
              currentAccountPicture: CircleAvatar(
                    child: Icon(Icons.person), 
              ),
            ),
            ListTile(
              title: Text('Weather Buddy',
                  style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NextPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.lightBlueAccent], 
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome leads",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "My name is Jia Shah.",
                style: TextStyle(fontSize: 20),
              ),
              Container(
                width: 250,
                child: Text(
                  "I am pursuing Btech CSE and am currently in the first year.",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: 300, 
                child: Text(
                  "This weather app has the following features:",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 20), 
              Container(
                width: 300, 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "1. This app's primary purpose is to show the current weather in an area.",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "2. It displays information about the creator.",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "3. Has a notification icon which when clicked shows notification.",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "4. Advises the user on the appropriate measures to be taken during the weather.",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeatherPage()),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 12, horizontal: 25), 
                  child: Text(
                    'Check Weather',
                    style: TextStyle(
                      fontSize: 20, 
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//first paage
class NextPage extends StatelessWidget {
  // Weather suggestions
  final Map<String, String> weatherSuggestions = {
    '     Sunny':
        'Wear sunscreen and stay hydrated. Make sure to carry an umbrealla too.',
    '     Rainy':
        'Bring an umbrella and wear waterproof clothing. Keep electronic devices dry.',
    '     Cloudy':
        'Carry a light jacket for sudden weather changes. Carry an umbrella too.',
    '     Snowy':
        'Wear layers and insulated clothing to stay warm. Stay in warm places and avoid going out.',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather Buddy',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 4,
      ),
      body: Center(
        child: Column(
          children: [
            // Weather suggestions
            for (String weather in weatherSuggestions.keys)
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          weather,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(width: 10), 
                      ElevatedButton(
                        onPressed: () {
                          _showWeatherDescription(context, weather);
                        },
                        child: Text('Know more'),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  void _showWeatherDescription(BuildContext context, String weather) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Things to keep in mind'),
          content:
              Text(weatherSuggestions[weather] ?? 'No description available'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

//second page
class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String apiUrl =
      'https://api.openweathermap.org/data/2.5/weather?q=Chennai&appid=caf56d5439e9a04bf7a287666fa31517';

  Future<Map<String, dynamic>> fetchWeather() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
        elevation: 4,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.lightBlueAccent], // Gradient colors
          ),
        ),
        child: Center(
          child: FutureBuilder(
            future: fetchWeather(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                var weatherData = snapshot.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'City: ${weatherData?['name']}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Temperature: ${weatherData?['main']['temp']}°F',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Description: ${weatherData?['weather'][0]['description']}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
