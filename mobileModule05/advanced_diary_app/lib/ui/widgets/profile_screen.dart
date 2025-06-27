import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_body_user_screen.dart';
import 'profile_body_entries_screen.dart';
import 'profile_feelings_screen.dart';
import 'add_entry_screen.dart';
import 'agenda_screen.dart';

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
                    ProfileFeelingsScreen()
                  ],
                ),
            ),
            Container(
              padding: const EdgeInsets.all(40),  
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AgendaScreen(),
                          ),  
                        );  
                      },
                      child: Icon(
                        Icons.calendar_month,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

