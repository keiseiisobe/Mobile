import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'controller.dart';

class Calculator extends StatefulWidget {
  final bool isLightMode;  
  const Calculator({
    super.key,
    this.isLightMode = true,
  });

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  late Controller controller;
  @override
  Widget build(BuildContext context) {
    controller = Controller();  
    return Column(
      children: [
        Expanded(child: _CalcDisplay(controller: controller)),
        Expanded(
          flex: 2,  
          child: getButtons()
        ),
      ],  
    );
  }

  Widget getButtons() {
    return GridButton(
      items: getItem(),
      onPressed: (dynamic val) {
        if (isDigit(val, positiveOnly: true) || val == "00") {
          controller.digit(val);
        }
        else if (val == ".") {
          controller.dot();
        }
        else if (val == "AC") {
          controller.ac();  
        }
        else if (val == "C") {
          controller.c();
        }
        else if (val == "=") {
          controller.equal();
        }
        else if (val == "+" || val == "x" || val == "/") {
          controller.operatorExceptMinus(val);
        }
        else if (val == "-") {
          controller.minus();
        }
      }
    );
  }

  List<List<GridButtonItem>> getItem() {
    final textStyle = TextStyle(
      fontSize: 30,
      color: widget.isLightMode ? Colors.black : Colors.white,
    );  
    final red = Colors.red;
    final blue = Colors.blue;
    final green = Colors.green;
    final transparent = Colors.transparent;
    return [
      [
        GridButtonItem(title: "7", color: transparent, textStyle: textStyle),
        GridButtonItem(title: "8", color: transparent, textStyle: textStyle),
        GridButtonItem(title: "9", color: transparent, textStyle: textStyle),
        GridButtonItem(title: "C", color: red, textStyle: textStyle),
        GridButtonItem(title: "AC", color: red, textStyle: textStyle),
      ],
      [
        GridButtonItem(title: "4", color: transparent, textStyle: textStyle),
        GridButtonItem(title: "5", color: transparent, textStyle: textStyle),
        GridButtonItem(title: "6", color: transparent, textStyle: textStyle),
        GridButtonItem(title: "+", color: blue, textStyle: textStyle),
        GridButtonItem(title: "-", color: blue, textStyle: textStyle),
      ],
      [
        GridButtonItem(title: "1", color: transparent, textStyle: textStyle),
        GridButtonItem(title: "2", color: transparent, textStyle: textStyle),
        GridButtonItem(title: "3", color: transparent, textStyle: textStyle),
        GridButtonItem(title: "x", color: blue, textStyle: textStyle),
        GridButtonItem(title: "/", color: blue, textStyle: textStyle),
      ],
      [
        GridButtonItem(title: "0", color: transparent, textStyle: textStyle),
        GridButtonItem(title: ".", color: transparent, textStyle: textStyle),
        GridButtonItem(title: "00", color: transparent, textStyle: textStyle),
        GridButtonItem(title: "=", color: green, textStyle: textStyle),
        GridButtonItem(title: "", color: transparent, textStyle: textStyle),
      ],
    ];
  }
}

class _CalcDisplay extends StatelessWidget {
  final Controller controller;  
  const _CalcDisplay({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.all(20),  
                child: ListenableBuilder(
                  listenable: controller,
                  builder: (context, _) => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,  
                    child: Text(
                      controller.result,
                      maxLines: 1,
                      style: TextStyle(fontSize: 50),
                    ),                    
                  )
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.all(20),  
                child: ListenableBuilder(
                  listenable: controller,
                  builder: (context, _) => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,  
                    child: Text(
                      controller.expression,
                      maxLines: 1,
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                )
              )
            )
          )
        ],  
      ),
    );
  }
}















