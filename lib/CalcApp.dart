import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

const Color colorDark = Color(0xFF374352);
const Color colorLight = Color(0xFFe6eeff);

class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double FirstNum = 0.0;
  double SecondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';

  bool darkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? colorDark : colorLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            darkMode ? darkMode = false : darkMode = true;
                          });
                        },
                        child: _switchMode()),
                    SizedBox(height: 80),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        input,
                        style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: darkMode
                                ? Colors.white
                                : Color.fromARGB(255, 197, 136, 179)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '=',
                          style: TextStyle(
                              fontSize: 35,
                              color: darkMode
                                  ? Colors.white
                                  : Color.fromARGB(255, 197, 136, 179)),
                        ),
                        Text(
                          output,
                          style: TextStyle(
                              fontSize: 34,
                              color: darkMode
                                  ? Colors.white.withOpacity(0.7)
                                  : Color.fromARGB(255, 197, 136, 179)
                                      .withOpacity(0.7)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              Container(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonOval(title: 'sin'),
                      _buttonOval(title: 'cos'),
                      _buttonOval(title: 'tan'),
                      _buttonOval(title: '%')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(
                          title: 'C',
                          textColor: darkMode
                              ? Color.fromARGB(255, 245, 166, 49)
                              : Color.fromARGB(255, 197, 136, 179)),
                      _buttonRounded(title: '('),
                      _buttonRounded(title: ')'),
                      _buttonRounded(
                          title: '/',
                          textColor: darkMode
                              ? Color.fromARGB(255, 245, 166, 49)
                              : Color.fromARGB(255, 197, 136, 179))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(title: '7'),
                      _buttonRounded(title: '8'),
                      _buttonRounded(title: '9'),
                      _buttonRounded(
                          title: 'X',
                          textColor: darkMode
                              ? Color.fromARGB(255, 245, 166, 49)
                              : Color.fromARGB(255, 197, 136, 179))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(title: '4'),
                      _buttonRounded(title: '5'),
                      _buttonRounded(title: '6'),
                      _buttonRounded(
                          title: '-',
                          textColor: darkMode
                              ? Color.fromARGB(255, 245, 166, 49)
                              : Color.fromARGB(255, 197, 136, 179))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(title: '1'),
                      _buttonRounded(title: '2'),
                      _buttonRounded(title: '3'),
                      _buttonRounded(
                          title: '+',
                          textColor: darkMode
                              ? Color.fromARGB(255, 245, 166, 49)
                              : Color.fromARGB(255, 197, 136, 179))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(title: '0'),
                      _buttonRounded(title: ','),
                      _buttonRounded(
                          title: '<<',
                          textColor: darkMode
                              ? Color.fromARGB(255, 245, 166, 49)
                              : Color.fromARGB(255, 197, 136, 179)),
                      _buttonRounded(
                          title: '=',
                          textColor: darkMode
                              ? Color.fromARGB(255, 245, 166, 49)
                              : Color.fromARGB(255, 197, 136, 179))
                    ],
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double eval(String expression) {
    // Use the 'eval' function from the 'dart:math' library to evaluate the expression
    return double.parse(expression);
  }

  Widget _buttonRounded(
      {String? title,
      double padding = 17,
      IconData? icon,
      Color? iconColor,
      Color? textColor}) {
    onButtonClick(value) {
      if (value == 'C') {
        input = '';
        output = '';
      } else if (value == '<<') {
        input = input.substring(0, input.length - 1);
      } else if (value == '=') {
        var InputUser = input;
        InputUser = input.replaceAll("X", "*");
        Parser p = Parser();
        Expression expression = p.parse(InputUser);
        ContextModel cm = ContextModel();
        var resualt = expression.evaluate(EvaluationType.REAL, cm);
        output = resualt.toString();
      } else {
        input = input + value;
      }
      setState(() {});
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () => onButtonClick(title),
        child: NeuContainer(
          darkMode: darkMode,
          borderRadius: BorderRadius.circular(40),
          padding: EdgeInsets.all(padding),
          child: Container(
            width: padding * 2,
            height: padding * 2,
            child: Center(
                child: title != null
                    ? Text(
                        '$title',
                        style: TextStyle(
                            color: textColor != null
                                ? textColor
                                : darkMode
                                    ? Colors.white
                                    : Colors.black,
                            fontSize: 30),
                      )
                    : Icon(
                        icon,
                        color: iconColor,
                        size: 30,
                      )),
          ),
        ),
      ),
    );
  }

  Widget _buttonOval({String? title, double padding = 17}) {
    onButtonClick(value) {
      if (value == 'C') {
        input = '';
        output = '';
      } else if (value == '<<') {
        input = input.substring(0, input.length - 1);
      } else if (value == '=') {
        try {
          // Use the 'eval' function from the 'dart:math' library to evaluate the expression
          final result = eval(output);
          output = result.toString();
        } catch (e) {
          output = 'Error';
        }
      } else {
        input = input + value;
      }
      setState(() {});
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () => onButtonClick(title),
        child: NeuContainer(
          darkMode: darkMode,
          borderRadius: BorderRadius.circular(50),
          padding:
              EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
          child: Container(
            width: padding * 2,
            child: Center(
              child: Text(
                '$title',
                style: TextStyle(
                    color: darkMode ? Colors.white : Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _switchMode() {
    return NeuContainer(
      darkMode: darkMode,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 70,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Icon(
            Icons.wb_sunny,
            color: darkMode ? Colors.grey : Color.fromARGB(255, 197, 136, 179),
          ),
          Icon(
            Icons.nightlight_round,
            color: darkMode ? Color.fromARGB(255, 245, 166, 49) : Colors.grey,
          ),
        ]),
      ),
    );
  }
}

class NeuContainer extends StatefulWidget {
  final bool darkMode;
  final Widget? child;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  NeuContainer(
      {this.darkMode = false, this.child, this.borderRadius, this.padding});

  @override
  _NeuContainerState createState() => _NeuContainerState();
}

class _NeuContainerState extends State<NeuContainer> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = widget.darkMode;
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: Container(
        padding: widget.padding,
        decoration: BoxDecoration(
            color: darkMode ? colorDark : colorLight,
            borderRadius: widget.borderRadius,
            boxShadow: _isPressed
                ? null
                : [
                    BoxShadow(
                      color:
                          darkMode ? Colors.black54 : Colors.blueGrey.shade200,
                      offset: Offset(4.0, 4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0,
                    ),
                    BoxShadow(
                        color:
                            darkMode ? Colors.blueGrey.shade700 : Colors.white,
                        offset: Offset(-4.0, -4.0),
                        blurRadius: 15.0,
                        spreadRadius: 1.0)
                  ]),
        child: widget.child,
      ),
    );
  }
}
