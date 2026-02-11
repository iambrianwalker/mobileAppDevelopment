// main.dart
import 'package:flutter/material.dart';

// The main entry point of the app
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<MaterialColor> _colors = [Colors.red, Colors.blue, Colors.green];
  final List<String> _colorNames = ['Red', 'Blue', 'Green'];
  int _currentColorIndex = 0;

  void _toggleColor() {
    setState(() {
      _currentColorIndex = (_currentColorIndex + 1) % _colors.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // TASK 1: Change the title of the app
      title: 'My Amazing App',
      theme: ThemeData(
        // TASK 2: Change the primary swatch color (try Colors.red, Colors.green)
        primarySwatch: _colors[_currentColorIndex], 
        appBarTheme: AppBarTheme(backgroundColor: _colors[_currentColorIndex]),
      ),
      home: HomePage(onToggleColor: _toggleColor, currentColorIndex: _currentColorIndex, colorNames: _colorNames, currentColor: _colors[_currentColorIndex]),
    );
  }
}


class HomePage extends StatelessWidget {
  final VoidCallback onToggleColor;
  final int currentColorIndex;
  final List<String> colorNames;
  final MaterialColor currentColor;

  const HomePage({super.key, required this.onToggleColor, required this.currentColorIndex, required this.colorNames, required this.currentColor});

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
            Card(
              elevation: 4, 
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.person, size: 30, color: Colors.red),
                    SizedBox(width: 16),
                    Column(
                      children: [
                        Text('Brian Walker',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Major: Computer Science',
                        style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
              style: ElevatedButton.styleFrom(backgroundColor: currentColor),
              child: Text('Press'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onToggleColor,
              style: ElevatedButton.styleFrom(backgroundColor: currentColor),
              child: Text('Change Color Palette'),
            ),
            SizedBox(height: 20),
            Text('Current color: ${colorNames[currentColorIndex]}'),
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

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('Count: $_count', style: TextStyle(fontSize: 24)),
      Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(child: 
        onPressed: () => setState(() => _count--),
        child: Icon(Icons.remove),
        ),
        SizedBox(width: 20),
        ElevatedButton(child:
        onPressed: () => setState(() => _count++),
        child: Icon(Icons.add),
        ),
      ],
      ),
    ],
    );
  }
}