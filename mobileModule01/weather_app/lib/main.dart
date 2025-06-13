import 'dart:io';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowMinSize(Size(300, 400));
  }
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

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late final TabController tabController;
  final TextEditingController searchController = TextEditingController();
  var isGeoLocationEnabled = false;
  var isSearchLocationEnabled = false;

  List<Widget> getBottomNavigationBarItems() {
    return [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Expanded(child: const Icon(Icons.wb_sunny)),
            SizedBox(height: 4),
            Expanded(child: Text("Currently")),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Expanded(child: const Icon(Icons.calendar_today)),
            SizedBox(height: 4),
            Expanded(child: Text("Today")),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Expanded(child: const Icon(Icons.calendar_view_week)),
            SizedBox(height: 4),
            Expanded(child: Text("Weekly")),
        ],
      ),
    ];
  }

  List<Widget> getTopBarItems() {
    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.8,
        alignment: Alignment.bottomLeft,
        child: TextField(
          controller: searchController, 
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          cursorColor: Theme.of(context).colorScheme.onPrimary,
          decoration: InputDecoration(
            hintText: "Search location...",
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.primaryContainer),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
            prefixIconColor: Theme.of(context).colorScheme.primaryContainer,
            counterText: "",
          ),
          maxLength: 100,
          onSubmitted: (value) {
            setState(() {
              isSearchLocationEnabled = true;
              isGeoLocationEnabled = false;
            });  
          },
        ),
      ),
      VerticalDivider(
        color: Theme.of(context).colorScheme.onPrimary,
        indent: 10,
        endIndent: 10,
        width: 0,
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.2,
        alignment: Alignment.center,
        child: IconButton(
          onPressed: () {
            setState(() {
              if (isGeoLocationEnabled) {
                isGeoLocationEnabled = false;
              } else {
                isGeoLocationEnabled = true;
                isSearchLocationEnabled = false;
              }  
            });  
          },
          icon: Icon(
            Icons.near_me,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          constraints: BoxConstraints.expand(),
        ),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();  
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,  
        flexibleSpace: SafeArea(
          child: TabBar(
            controller: tabController,  
            tabAlignment: TabAlignment.start,  
            labelPadding: EdgeInsets.only(top: 8),
            isScrollable: true,
            dividerColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            labelColor: Colors.transparent,
            unselectedLabelColor: Colors.transparent,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            mouseCursor: SystemMouseCursors.basic,
            tabs: getTopBarItems(),
            onTap: (index) {
              setState(() {
                tabController.index = tabController.previousIndex;
              });
            },
          ),
        ),
      ),  
      bottomNavigationBar: BottomAppBar(
        child: TabBar(
          controller: tabController,  
          tabs: getBottomNavigationBarItems()
        ),
      ),
      body: SafeArea(
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),  
          child: TabBarView(
            controller: tabController,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,  
                children: [
                  Text("Currently"),
                  isGeoLocationEnabled 
                    ? Text("Geolocation") 
                    : isSearchLocationEnabled 
                      ? Text(searchController.text) 
                      : Text(""),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,  
                children: [
                  Text("Today"),  
                  isGeoLocationEnabled 
                    ? Text("Geolocation") 
                    : isSearchLocationEnabled 
                      ? Text(searchController.text) 
                      : Text(""),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,  
                children: [
                  Text("Weekly"),  
                  isGeoLocationEnabled 
                    ? Text("Geolocation") 
                    : isSearchLocationEnabled 
                      ? Text(searchController.text) 
                      : Text(""),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

