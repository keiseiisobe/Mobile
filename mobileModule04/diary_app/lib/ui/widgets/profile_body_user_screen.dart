import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../main.dart';

class ProfileBodyUserScreen extends StatefulWidget {
  const ProfileBodyUserScreen(
    {super.key}
  );
  
  @override
  State<ProfileBodyUserScreen> createState() => _ProfileBodyUserScreenState();
}

class _ProfileBodyUserScreenState extends State<ProfileBodyUserScreen> {
  final _stream = db.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).snapshots();

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
        var data = asyncSnapshot.data!;
        return Container(
          padding: const EdgeInsets.all(20),  
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  data['photoURL'],
                ),
              ),
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['name'],
                    style: GoogleFonts.lobster(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,  
                    ),
                  ),
                  Text(
                    data['email'],
                    style: GoogleFonts.lobster(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,  
                    ),
                  ),
                ],  
              ),
            ],
          ),
        );
      },
    );
  }  
}