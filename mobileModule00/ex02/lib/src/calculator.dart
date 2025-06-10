import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';

class Calculator extends StatelessWidget {
  const Calculator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _CalcDisplay()),
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
        print("button pressed: $val");
      }
    );
  }

  List<List<GridButtonItem>> getItem() {
    final textStyle = TextStyle(
      fontSize: 30,
      color: Colors.grey.shade800,
    );  
    final white = Colors.white;
    final red = Colors.red;
    final blue = Colors.blue;
    final green = Colors.green;
    final transparent = Colors.transparent;
    return [
      [
        GridButtonItem(title: "7", color: white, textStyle: textStyle),
        GridButtonItem(title: "8", color: white, textStyle: textStyle),
        GridButtonItem(title: "9", color: white, textStyle: textStyle),
        GridButtonItem(title: "C", color: red, textStyle: textStyle),
        GridButtonItem(title: "AC", color: red, textStyle: textStyle),
      ],
      [
        GridButtonItem(title: "4", color: white, textStyle: textStyle),
        GridButtonItem(title: "5", color: white, textStyle: textStyle),
        GridButtonItem(title: "6", color: white, textStyle: textStyle),
        GridButtonItem(title: "+", color: blue, textStyle: textStyle),
        GridButtonItem(title: "-", color: blue, textStyle: textStyle),
      ],
      [
        GridButtonItem(title: "1", color: white, textStyle: textStyle),
        GridButtonItem(title: "2", color: white, textStyle: textStyle),
        GridButtonItem(title: "3", color: white, textStyle: textStyle),
        GridButtonItem(title: "x", color: blue, textStyle: textStyle),
        GridButtonItem(title: "/", color: blue, textStyle: textStyle),
      ],
      [
        GridButtonItem(title: "0", color: white, textStyle: textStyle),
        GridButtonItem(title: ".", color: white, textStyle: textStyle),
        GridButtonItem(title: "00", color: white, textStyle: textStyle),
        GridButtonItem(title: "=", color: green, textStyle: textStyle),
        GridButtonItem(title: "", color: transparent, textStyle: textStyle),
      ],
    ];
  }
}

class _CalcDisplay extends StatelessWidget {
  const _CalcDisplay();

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
                padding: EdgeInsets.all(10),  
                child: Text(
                  "0",
                  style: TextStyle(fontSize: 50),
                ),
              )
            ),
          ),  
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.all(10),  
                child: Text(
                  "0",
                  style: TextStyle(fontSize: 30),
                ),
              )
            )
          )
        ],  
      ),
    );
  }
}















