import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../main.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {

  Map data = {};
    
  @override
  void initState() {
    super.initState();
    loadData(FirebaseAuth.instance.currentUser);
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
          title: const Text('Profile'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),  
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        FirebaseAuth.instance.currentUser?.photoURL ?? 
                            'https://www.gravatar.com/avatar'),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          FirebaseAuth.instance.currentUser?.displayName ?? "Anonymous",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,  
                          ),
                        ),
                        Text(
                          FirebaseAuth.instance.currentUser?.email ?? "No email",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],  
                    ),
                  ],
                ),
              ),
              Text(
                data.toString(),
                style: TextStyle(color: Colors.white),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Add New Entry'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              db.collection("users").add({
                                "uid": FirebaseAuth.instance.currentUser?.uid,  
                                "name": FirebaseAuth.instance.currentUser?.displayName ?? "Anonymous",
                                "email": FirebaseAuth.instance.currentUser?.email,
                                "created_at": DateTime.now(),
                              });
                            },
                            child: const Text('Add New Entry'),
                          ),
                        ],
                      );
                    },  
                  );
                },
                child: const Text('Add New Entry'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void loadData(User? user) {
    if (user == null) {
      data = {};
    }
    db.collection('users').where('uid', isEqualTo: user?.uid).get().then((snapshot) {
      var doc = snapshot.docs[0];
      if (doc.exists) {
        setState(() {
          data = doc.data();
        });
      } else {
        setState(() {
          data = {"No data": "No data available"};
        });
      }
    }).catchError((error) {
      print("Error fetching user data: $error");
      setState(() {
        data = {};
      });
    });
  }  
}