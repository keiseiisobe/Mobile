import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../main.dart';
import 'entries_screen.dart';

class ProfileBodyEntriesScreen extends StatefulWidget {
  const ProfileBodyEntriesScreen({
    super.key,
  });

  @override
  State<ProfileBodyEntriesScreen> createState() => _ProfileBodyEntriesScreenState();
}

class _ProfileBodyEntriesScreenState extends State<ProfileBodyEntriesScreen> {
  final _stream = db.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('entries').orderBy('timestamp', descending: true).limit(2).snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _stream,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (asyncSnapshot.hasError) {
          return Center(child: Text('Error: ${asyncSnapshot.error}'));
        }  
        var data = asyncSnapshot.data!.docs;
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EntriesScreen(),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(100),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  'Latest Entries',
                  style: GoogleFonts.lobster(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                data.isNotEmpty
                  ? ListTile(
                    leading: Text(
                      DateFormat.yMMMMd().format(data[0]['timestamp']?.toDate()),
                      style: GoogleFonts.lobster(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    title: Text(
                      data[0]['title'] ?? 'No title',
                      style: GoogleFonts.lobster(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    trailing: feeling2Icon(data[0]['feeling'] ?? 'neutral', 30),
                  ) : ListTile(
                    title: Text(
                      'No entries available',
                      style: GoogleFonts.lobster(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      'Please add an entry to see it here.',
                      style: GoogleFonts.lobster(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    textColor: Colors.white,
                  ),
              data.length > 1
                ? ListTile(
                  leading: Text(
                    DateFormat.yMMMMd().format(data[1]['timestamp']?.toDate()),
                    style: GoogleFonts.lobster(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  title: Text(
                    data[1]['title'] ?? 'No title',
                    style: GoogleFonts.lobster(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  trailing: feeling2Icon(data[1]['feeling'] ?? 'neutral', 30),
                ) : const ListTile(
                  title: Text(''),
                  subtitle: Text(''),
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        );
      }
    );

  }
}