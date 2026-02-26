import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _display = '0';
  String _input = '';

  List<double> numberStack = [];
  List<String> operatorStack = [];

  double? _result;

  final _operand = Colors.grey;
  final _oper = Colors.red;

  double add(double num1, double num2){
    return num1 + num2;
  }

  double multiply(double num1, double num2){
    return num1 * num2;
  }

  double subtract(double num1, double num2){
    return num1 - num2;
  }

  double divide(double num1, double num2){
    if (num2 == 0){
      return 0;
    }
    return num1 / num2;
  }

  void _allClear(){
    setState(() {
      _display = '0';
      _input = '';
      _result = null;

      numberStack.clear();
      operatorStack.clear();
    });
  }

  void _posNeg(){
    setState(() {

      //When there is no number to switch
      if (_input.isEmpty || _input == '0'){
        return;
      }
      //To find the last operator position
      int lastOperatorIndex = _input.lastIndexOf(RegExp(r'[+\-*/]'));

      String currentNum;

      if (lastOperatorIndex == -1){
        currentNum = _input;
      } else {
        currentNum = _input.substring(lastOperatorIndex + 1);
      }

      if (currentNum.isEmpty){
        return;
      }
      
      //Add negative sign
      if (currentNum.startsWith('-')){
        currentNum = currentNum.substring(1);
      } else {
        currentNum = '-$currentNum';
      }

      if (lastOperatorIndex == -1) {
        _input = currentNum;
      } else {
        _input = _input.substring(0, lastOperatorIndex + 1) + currentNum;
      }

      _display = _input;
    });
  }

  void _calculate(){
    if (_input.isEmpty) return;

    setState(() {
      try{
        double result = parse(_input);

        _display = result.toString();
        _input = result.toString();

        numberStack.clear();
        operatorStack.clear();
      } catch (e) {
        _display = 'Error';
        _input = '';
      }
    });
  }

  double parse(String expression){
    numberStack.clear();
    operatorStack.clear();

    int i = 0;

    while (i < expression.length){
      if (RegExp(r'[0-9.]').hasMatch(expression[i]) ||
      (expression[i] == '-' && (i == 0 || _isOperator(expression[i - 1])))){
        String number = '';

        if (expression[i] == '-'){
          number += '-';
          i++;
        }

        while (i < expression.length &&
        RegExp(r'[0-9.]').hasMatch(expression[i])){
          number += expression[i];
          i++;
        }

        numberStack.add(double.parse(number));
        continue;
      }

      else if (_isOperator(expression[i])){
        while (operatorStack.isNotEmpty &&
        _hasPrecedence(operatorStack.last, expression[i])){
          double b = numberStack.removeLast();
          double a = numberStack.removeLast();
          String op = operatorStack.removeLast();

          numberStack.add(_applyOperator(a, b, op));
        }

        operatorStack.add(expression[i]);
      }

      i++;
    }

    while (operatorStack.isNotEmpty){
      double b = numberStack.removeLast();
      double a = numberStack.removeLast();
      String op = operatorStack.removeLast();

      numberStack.add(_applyOperator(a, b, op));
    }

    return numberStack.last;
  }

  bool _isOperator(String c){
    return c == '*' || c == '-' || c == '+' || c =='/';
  }

  bool _hasPrecedence(String op1, String op2) {
    if ((op1 == '*' || op1 == '/') && (op2 == '+' || op2 == '-')) {
      return true;
    }
    if ((op1 == '+' || op1 == '-') && (op2 == '+' || op2 == '-')) {
      return true;
    }
    if ((op1 == '*' || op1 == '/') && (op2 == '*' || op2 == '/')) {
      return true;
    }
    return false;
  }
  //I know the methods are useless here but it was the first thing I made so I'm going to use them.
  double _applyOperator(double a, double b, String op) {
    switch (op) {
      case '+':
        return add(a,b);
      case '-':
        return subtract(a,b);
      case '*':
        return multiply(a,b);
      case '/':
        return divide(a,b);
      default:
        throw Exception("Invalid operator");
    }
  }

    void _operator(String operator) {
    setState(() {

      if (_input.isEmpty) {
        // Allow negative number at start
        if (operator == "-") {
          _input = "-";
          _display = _input;
        }
        return;
      }

      // Prevent double operators like 5++
      if (_isOperator(_input[_input.length - 1])) {
        // Replace last operator instead of adding new one
        _input = _input.substring(0, _input.length - 1) + operator;
      } else {
        _input += operator;
      }

      _display = _input;
    });
  }

  String select(String value){
    switch (value){
      case 'AC':
        _allClear();
        return _display;

      case '+/-':
        _posNeg();
        return _display;

      case '/':
      case '+':
      case '*':
      case '-':
        _operator(value);
        return _display;
      
      case '=':
        _calculate();
        return _display;

      case '0':
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
      case '9':
        _handleNum(value);
        return _display;

      default:
        throw Exception('Not a function in this app');
    }
  }

  void _handleNum(String num){
    setState(() {
      if (_input == '0'){
        _input = num;
      } else {
        _input += num;
      }
      _display = _input;
    });
  }

  Widget _buildDisplay(){
    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.centerRight,
      width: 300,
      color: Colors.black,
      child: Text(
        _display,
        style: TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.bold
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      )
    );
  }

  Widget _buildButtonsGrid() {
    return Container(
      width: 300, // match display width
      child: GridView.count(
        shrinkWrap: true,          // prevent infinite height
        crossAxisCount: 4,         // 4 buttons per row
        mainAxisSpacing: 8,        // vertical spacing
        crossAxisSpacing: 8,       // horizontal spacing
        children: [
          _buildButton("AC", color: _operand),
          _buildButton("+/-", color: _operand),
          _buildButton("%", color: _operand),
          _buildButton("/", color: _operand),
          _buildButton("7", color: _oper),
          _buildButton("8", color: _oper),
          _buildButton("9", color: _oper),
          _buildButton("*", color: _operand),
          _buildButton("4", color: _oper),
          _buildButton("5", color: _oper),
          _buildButton("6", color: _oper),
          _buildButton("-", color: _operand),
          _buildButton("1", color: _oper),
          _buildButton("2", color: _oper),
          _buildButton("3", color: _oper),
          _buildButton("+", color: _operand),
          _buildButton("0",flex: 2, color: _oper),
          _buildButton(".", color: _operand),
          _buildButton("=", color: _operand),
        ],
      ),
    );
  }

  Widget _buildButton(String text, {Color? color, int flex = 1}) {
    return GridTile(
      child: ElevatedButton(
        onPressed: () => select(text),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: color ?? Colors.grey, // default button color
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Column(children: [
              _buildDisplay(),
              SizedBox(height: 16),
              _buildButtonsGrid()
            ],)
          ],
        ),
      ),
    );
  }
}
