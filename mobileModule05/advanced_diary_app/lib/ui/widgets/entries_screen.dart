import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_entry_screen.dart';
import 'entry_detail_screen.dart';
import '../../main.dart';

class EntriesScreen extends StatefulWidget {
  const EntriesScreen({
    super.key,
  });

  @override
  State<EntriesScreen> createState() => _EntriesScreenState();
}

class _EntriesScreenState extends State<EntriesScreen> {
  final _stream = db.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('entries').orderBy('timestamp', descending: true).snapshots();

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
            'Entries',
            style: GoogleFonts.lobster(
              fontSize: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: StreamBuilder(
          stream: _stream,
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (asyncSnapshot.hasError) {
              return Center(child: Text('Error: ${asyncSnapshot.error}'));
            }
            var data = asyncSnapshot.data?.docs ?? [];
            return Column(
                  children: [
                    Text('Total Entries: ${data.length}',
                      style: GoogleFonts.lobster(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var entry = data[index];
                          return ListTile(
                            leading: Text(
                              DateFormat.yMMMMd().format(entry['timestamp']?.toDate()),
                              style: GoogleFonts.lobster(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            title: Text(
                              entry['title'] ?? 'No title',
                              style: GoogleFonts.lobster(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            trailing: feeling2Icon(entry['feeling'] ?? 'neutral', 30),
                            onTap: () {
                              showDialog<void>(
                                context: context,
                                builder: (context) {
                                  return EntryDetailScreen(
                                    entry: entry,  
                                  );
                                },
                              );  
                            }
                          );
                        },
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
            );
          },
        ),  
      ),
    );
    }
}

Icon feeling2Icon(String feeling, double size) {
  switch (feeling) {
    case 'very happy':
      return Icon(Icons.sentiment_very_satisfied, color: Colors.red, size: size);
    case 'happy':
      return Icon(Icons.sentiment_satisfied, color: Colors.orange, size: size);
    case 'sad':
      return Icon(Icons.sentiment_dissatisfied, color: Colors.blue, size: size);
    case 'very sad':
      return Icon(Icons.sentiment_very_dissatisfied, color: Colors.purple, size: size);
    default:
      return Icon(Icons.sentiment_neutral, color: Colors.green, size: size);
  }
}