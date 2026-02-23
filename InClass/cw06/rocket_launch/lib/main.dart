import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rocket Launch Controller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  // set counter value
  int _counter = 0;
  Color _textColor = Colors.black;
  final text = Text('LIFTOFF!!!!');

  void _ignite(){
    setState(() {
      _counter++;
      if (_counter > 99){
        _counter = 100;
      }
      _level(_counter);
    });
    
  }

  void _decrement(){
    setState(() {
      _counter--;
      if (_counter < 1){
        _counter = 0;
      }
      _level(_counter);
    });
  }

  void _reset(){
    setState(() {
      if (_counter > 0){
        _counter = 0;
        _level(_counter);
      }
    });
  }

  void _level(int counter){
    setState(() {
      if (counter == 0){
        _textColor = Colors.red;
      } else if (counter < 51){
        _textColor = Colors.orange;
      } else{
        _textColor = Colors.green;
      }
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rocket Launch Controller'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              color: Colors.blue,
              child: Text( 
                _counter == 100 ? 'LIFTOFF!!!'
                :'$_counter',
                style: TextStyle(fontSize: 50.0, color: _textColor),
              ),
            ),
          ),
          Slider(
            min: 0,
            max: 100,
            value: _counter.toDouble(),
            onChanged: (double value) {
              setState(() {
                _counter = value.toInt();
                _level(_counter);
              });
            },
            activeColor: Colors.blue,
            inactiveColor: Colors.red,
          ),
          Row(
            children: [
              ElevatedButton(onPressed: _ignite, child: Text('Ignite!')),
              ElevatedButton(onPressed: _decrement, child: Text('Decrement')),
              ElevatedButton(onPressed: _reset, child: Text('Abort!'))
            ],
          )
        ],
      ),
    );
  }
}