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

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var msg = "A simple text";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,  
            children: [
              Title(msg: msg),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (msg == "A simple text") {
                      msg = "Hello World!";
                    } else {
                      msg = "A simple text";
                    }
                  });  
                },
                child: Text("Click me"),  
              )  
            ]
          )  
        )
    );
  }
}

class Title extends StatelessWidget {
  final String msg;

  const Title({
    super.key,
    required this.msg,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);  
    return Card(
      color: theme.colorScheme.primary,  
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          msg,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          )),
      ), 
    );
  }
}
