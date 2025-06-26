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
                      return _MyDialogScreen();
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

class _MyDialogScreen extends StatefulWidget {
  const _MyDialogScreen();

  @override
  State<_MyDialogScreen> createState() => _MyDialogScreenState();
}

class _MyDialogScreenState extends State<_MyDialogScreen> {
  dynamic _selectedFeeling = 'neutral';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Add New Entry'),
      contentPadding: const EdgeInsets.all(20),
      children: [
        Form(
          key: _formKey,  
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,  
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              DropdownButton(
                // defaut value to neutral
                value: _selectedFeeling,
                items: [
                  DropdownMenuItem(
                    value: 'very happy',  
                    child: Icon(
                      Icons.sentiment_very_satisfied,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),  
                  DropdownMenuItem(
                    value: 'happy',  
                    child: Icon(
                      Icons.sentiment_satisfied,
                      color: Colors.orange,
                      size: 30,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'neutral',  
                    child: Icon(
                      Icons.sentiment_neutral,
                      color: Colors.green,
                      size: 30,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'sad',  
                    child: Icon(
                      Icons.sentiment_dissatisfied,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'very sad',  
                    child: Icon(
                      Icons.sentiment_very_dissatisfied,
                      color: Colors.purple,
                      size: 30,
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedFeeling = value;
                  });
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _contentController,  
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
                maxLines: 5,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    db.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('entries').add({
                      'title': _titleController.text,
                      'feeling': _selectedFeeling,
                      'content': _contentController.text,
                      'timestamp': DateTime.now(),
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Entry'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}