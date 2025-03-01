import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = "";
  String _output = "0";
  double _num1 = 0;  // inadverdantly allows for decimals, int with how program is written caused input issues
  double _num2 = 0;
  String _operator = "";

  void _onPressed(String value) {  //button logic
    setState(() {
      if (value == "C") {  // clears and zeros out values
        _input = "";
        _output = "0";
        _num1 = 0;
        _num2 = 0;
        _operator = "";
      } else if (value == "=") {  // starts the handling of operator logic after '=' is pressed
        _num2 = double.parse(_input);
        if (_operator == "+") {
          _output = (_num1 + _num2).toString();
        } else if (_operator == "-") {
          _output = (_num1 - _num2).toString();
        } else if (_operator == "*") {
          _output = (_num1 * _num2).toString();
        } else if (_operator == "/") {
          _output = (_num1 / _num2).toString();
        }
        _input = _output;
        _operator = "";
      } else if (value == "+" || value == "-" || value == "*" || value == "/") {  // stores operator
        _num1 = double.parse(_input);
        _operator = value;
        _input = "";
      } else {
        _input += value;
        _output = _input;
      }
    });
  }

  Widget _buildButton(String text) {  // construction of base button widget
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onPressed(text),
        child: Text(text, style: TextStyle(fontSize: 24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator")),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(  // display of output and its styling
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24),
              child: Text(
                _output,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [  // calling button widget left to right in rows stacked in a column
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("/")
                ],
              ),
              Row(
                children: [
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("*")
                ],
              ),
              Row(
                children: [
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("-")
                ],
              ),
              Row(
                children: [
                  _buildButton("C"),
                  _buildButton("0"),
                  _buildButton("="),
                  _buildButton("+")
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}