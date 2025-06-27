import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_body_user_screen.dart';
import 'profile_body_entries_screen.dart';
import 'add_entry_screen.dart';
import 'entries_screen.dart' show feeling2Icon;

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background_profile.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,  
        appBar: AppBar(
          title: Text(
            'Profile',
            style: GoogleFonts.lobster(
              fontSize: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                try {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                } catch (e) {
                  print('Error signing out: $e');
                }  
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                  children: [
                    ProfileBodyUserScreen(),
                    ProfileBodyEntriesScreen(),
                    Text(
                      'Feelings Overview',
                      style: GoogleFonts.lobster(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,  
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildFeelingsOverview(),
                      )
                    ),
                  ],
                ),
            ),
            Container(
              padding: const EdgeInsets.all(40),  
              child: ElevatedButton(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (context) {
                      return AddEntryScreen();
                    },  
                  );
                },
                child: Text(
                  'Add New Entry',
                  style: GoogleFonts.lobster(
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
        ),
      );
  }

  List<ListTile>  _buildFeelingsOverview() {
    var feelings = [
      {'feeling': 'very happy', 'title': 'Joy Ascendant', 'subtitle': 'A Heart\'s Merry Dance, a Soul\'s Bright Dawn'},
      {'feeling': 'happy', 'title': 'Sweet Contentment', 'subtitle': 'A Gentle Smile, a Peaceful Ease'},
      {'feeling': 'neutral', 'title': 'Calm Equanimity', 'subtitle': 'A Still Lake, a Balanced Scale'},
      {'feeling': 'sad', 'title': 'Sorrow\'s Shadow', 'subtitle': 'A Heavy Heart, a Lingering Sigh'},
      {'feeling': 'very sad', 'title': 'Profound Lament', 'subtitle': 'A Soul\'s Deep Woe, a Cry from the Abyss'},
    ];
    return feelings.map((feeling) {
      return ListTile(
        leading: feeling2Icon(feeling['feeling']!, 30),
        title: Text(
          feeling['title']!,
          style: GoogleFonts.lobster(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )
        ),
        subtitle: Text(
          feeling['subtitle']!,
          style: GoogleFonts.lobster(
            color: Colors.white,
            fontSize: 16,
          )
        ),
      );
    }).toList();  
  }  
}

