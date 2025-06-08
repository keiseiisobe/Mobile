import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ex01',
      home: MyHomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(102, 102, 0, 1),
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = "A simple text";

  void getNext() {
    if (current == "A simple text") {
      current = "Hello Wolrd!";
    } else {
      current = "A simple text";
    }
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,  
            children: [
              Title(),
              ElevatedButton(
                onPressed: () => appState.getNext(),
                child: Text("Click me"),  
              )  
            ]
          )  
        )
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);  
        return Card(
      color: theme.colorScheme.primary,  
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "simple text",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            )),
      ),
    );
  }
}
