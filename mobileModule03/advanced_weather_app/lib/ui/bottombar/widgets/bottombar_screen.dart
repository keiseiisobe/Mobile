import 'package:flutter/material.dart';

class BottomBarScreen extends StatelessWidget {
  const BottomBarScreen({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,  
      child: TabBar(
        controller: tabController,  
        tabs: [
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
        ],
      ),
    );
  }
}