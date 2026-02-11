import 'package:flutter/material.dart';

void main() {
  runApp(const RunMyApp());
}

class RunMyApp extends StatefulWidget {
  const RunMyApp({super.key});

  @override
  State<RunMyApp> createState() => _RunMyAppState();
}

class _RunMyAppState extends State<RunMyApp> {
  // Variable to manage the current theme mode
  ThemeMode _themeMode = ThemeMode.system;

  // Method to toggle the theme
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Theme Demo',
      
      // TODO: Customize these themes further if desired
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.white, // Light mode background
      ),
      darkTheme: ThemeData.dark(), // Dark mode configuration
      
      themeMode: _themeMode, // Connects the state to the app

      home: Scaffold(
        appBar: AppBar(
          title: const Text('Theme Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // PART 1 TASK: Container and Text
              Container(
                width: 300,
                height: 200,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  // Use a ternary operator to check theme brightness
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Mobile App Development Testing',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              
              const SizedBox(height: 20),
              
              Text('Choose the Theme:', style: Theme.of(context).textTheme.bodyLarge),
              
              const SizedBox(height: 10),

              // Example implementation merging Tasks 1, 2, and 3
              AnimatedContainer(
                duration: const Duration(milliseconds: 1000), // Task 3
                color: _themeMode == ThemeMode.dark ? Colors.white : Colors.grey, // Task 1
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text('Mobile App Development Testing', style: Theme.of(context).textTheme.bodyLarge),
                    
                    // Task 2 & 4: Switch with Dynamic Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_themeMode == ThemeMode.dark ? Icons.nightlight_round : Icons.wb_sunny),
                        Switch(
                          value: _themeMode == ThemeMode.dark,
                          onChanged: (isDark) {
                            setState(() {
                              _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
                            });
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // PART 1 TASK: Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => changeTheme(ThemeMode.light),
                    child: const Text('Light Theme'),
                  ),
                  ElevatedButton(
                    onPressed: () => changeTheme(ThemeMode.dark),
                    child: const Text('Dark Theme'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
        