import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  setWindowMinSize(Size(250, 400));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(),
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
  PageController pageController = PageController(
    initialPage: 0,
  );  
  var pageSelected = 0;

  List<Widget> getBottomNavigationBarItems() {
    return [
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,  
              child: IconButton(
                isSelected: pageSelected == 0,
                icon: const Icon(Icons.wb_sunny),
                onPressed: () {
                  setState(() {
                    pageSelected = 0;  
                  });  
                  pageController.jumpToPage(0);  
                },
              )
            ),
            Expanded(child: Text("Currently"))
          ],
        ),
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,  
              child: IconButton(
                isSelected: pageSelected == 1,  
                icon: const Icon(Icons.calendar_today),
                onPressed: () {
                  setState(() {
                    pageSelected = 1;
                  });  
                  pageController.jumpToPage(1);
                },
              )
            ),
            Expanded(child: Text("Today"))
          ],
        ),
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,  
              child: IconButton(
                isSelected: pageSelected == 2,  
                icon: const Icon(Icons.calendar_view_week),
                onPressed: () {
                  setState(() {
                    pageSelected = 2;
                  });  
                  pageController.jumpToPage(2);  
                },
              )
            ),  
            Expanded(child: Text("Weekly"))
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,  
          flexibleSpace: TabBar(
            tabAlignment: TabAlignment.start,  
            isScrollable: true,
            labelPadding: EdgeInsets.zero,
            indicatorPadding: EdgeInsets.symmetric(vertical: 10),
            indicator: ShapeDecoration(shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100.0)),
            )),


            tabs: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                alignment: Alignment.bottomCenter,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search location...",
                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.primaryContainer),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 2.0,  
                      style: BorderStyle.solid
                    ),
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.near_me,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: () {
                    // Action for the near me button
                  },
                ),
              ),
            ],  
          ),
        ),  
        bottomNavigationBar: BottomAppBar(
          child: Row(children: getBottomNavigationBarItems()),
        ),
        body: PageView(
          controller: pageController,
          children: [
            Center(child: Text("Currently")),
            Center(child: Text("Today")),
            Center(child: Text("Weekly")),
          ],
        ),
      )
    );
  }
}

