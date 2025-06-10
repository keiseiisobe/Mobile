import 'package:flutter/foundation.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:function_tree/function_tree.dart';

class Controller extends ChangeNotifier {
  var _result = "0";
  var _expression = "0";

  String get result => _result;
  String get expression => _expression;

  void digit(String number) {
    if (_expression == "0") {
      if (number == "00") {
        number = "0";
      }  
      _expression = number;
    } else {
      _expression += number;
    }
    notifyListeners();
  }

  void dot() {
    if (_expression.contains('.')) {
      return;
    }
    if (isDigit(_expression[_expression.length - 1], positiveOnly: true)) {
      _expression += ".";
      notifyListeners();
    }
  }

  void ac() {
    _result = "0";
    _expression = "0";
    notifyListeners();
  }

  void c() {
    if (_expression.length > 1) {
      _expression = _expression.substring(0, _expression.length - 1);
    } else {
      _expression = "0";
    }
    notifyListeners();
  }

  void operatorExceptMinus(String operator) {
    if (isDigit(_expression[_expression.length - 1])) {
      _expression += operator;
      notifyListeners();  
    }
  }

  void minus() {
    if (_expression == "0") {
      _expression = "-";
    } else if (isDigit(_expression[_expression.length - 1], positiveOnly: true)) {
      _expression += '-';
    }
    notifyListeners();
  }  

  void equal() {
    bool isInt(num value) => value is int || value == value.toInt();

    if (!isDigit(_expression[_expression.length - 1], positiveOnly: true)) {
      return;
    }
    final expressionAfterReplace = _expression.replaceAll(RegExp(r'x'), '*');
    try {
      num temp = expressionAfterReplace.interpret();
      if (isInt(temp)) {
        _result = temp.toInt().toString();
      } else {
        _result = temp.toString();
      }
      _expression = _result;
      notifyListeners();
    } catch (e) {
      _result = "Impossible";
      _expression = "0";
      notifyListeners();
      return;
    }
  }  
}