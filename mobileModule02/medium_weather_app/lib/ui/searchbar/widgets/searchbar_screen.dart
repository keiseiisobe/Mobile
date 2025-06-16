import 'package:flutter/material.dart';

class SearchbarScreen extends StatelessWidget {
  const SearchbarScreen({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      ),
    );
  }
}