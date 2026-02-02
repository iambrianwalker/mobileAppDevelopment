// main.dart
import 'package:flutter/material.dart';

// The main entry point of the app
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // TASK 1: Change the title of the app
      title: 'My Amazing App',
      theme: ThemeData(
        // TASK 2: Change the primary swatch color (try Colors.red, Colors.green)
        primarySwatch: Colors.red, 
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
        // TASK 3: Change the text in the top bar
        title: Text('My android emulator does not work'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TASK 4: Change the main text below
            Text(
              'Welcome to my app',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20), // Adds space between widgets
            // TASK 5: Change the subtitle text
            Text(
              'I\'m trying my best',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('Button Clicked!');
              },
              // TASK 6: Change the text on the button
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('Press'),
            ),
            SizedBox(height: 30),
            Text(
              'Created by: Brian Walker'
            )
          ],
        ),
      ),
    );
  }
}