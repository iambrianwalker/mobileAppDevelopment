import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stateful Lab',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0; // This is our STATE

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _reset_0(){
    setState(() {
      _counter = 0;
    });
  }

  void _decrement(){
    setState(() {
      if(_counter > 0){
        _counter--;
      }
    });
  }

  Color get counterColor{
    if (_counter ==0){
      return Colors.red;
    }
    if (_counter > 50){
      return Colors.green;
    }
    return Colors.black;
  }

  late TextEditingController _controller;

  @override
  void initState(){
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  void _setValue() {
    final value = int.tryParse(_controller.text) ?? 0;

    if (value > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Limit Reached!"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    
    setState(() {
      _counter = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Interactive Counter')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              color: Colors.blue.shade100,
              padding: EdgeInsets.all(20),
              child: Text(
                '$_counter',
                style: TextStyle(
                  fontSize: 50.0,
                  color: counterColor 
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
          ),
          ElevatedButton(
            onPressed: _setValue, 
            child: const Text('Set Value')
          ),
          Slider(
            min: 0, max: 100,
            value: _counter.toDouble(),
            onChanged: (double value) {
              // 👇 This triggers the UI rebuild
              setState(() {
                _counter = value.toInt();
              });
            },
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: _increment, 
                child: const Text('+')
              ),
              ElevatedButton(
                onPressed: _reset_0, 
              child: const Text('Reset')
              ),
              ElevatedButton(
                onPressed: _decrement, 
                child: Text('-1')
              ),
            ],
          ),
        ],
      ),
    );
  }
}