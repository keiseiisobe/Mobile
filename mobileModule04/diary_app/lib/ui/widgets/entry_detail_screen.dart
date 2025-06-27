import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'entries_screen.dart';
import '../../main.dart';

class EntryDetailScreen extends StatelessWidget {
  const EntryDetailScreen({
    super.key,
    required this.entry,
  });

  final QueryDocumentSnapshot<Map<String, dynamic>> entry;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        DateFormat.yMMMMd().format(entry['timestamp'].toDate()),
        style: GoogleFonts.lobster(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      contentPadding: const EdgeInsets.all(20),
      children: [
        Text(
          entry['title'] ?? 'No Content',
          style: GoogleFonts.lobster(
            fontSize: 40,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        feeling2Icon(entry['feeling'], 40),
        const SizedBox(height: 10),
        Text(
          entry['content'] ?? 'No Content',
          style: GoogleFonts.lobster(
            fontSize: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Container(
          margin: EdgeInsets.all(15.0),
          child: ElevatedButton(
            onPressed: () {
              db.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('entries').doc(entry.id).delete();
              Navigator.pop(context);
            },
            child: Text(
              'Delete Entry',
              style: GoogleFonts.lobster(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    ); 
  }  
}