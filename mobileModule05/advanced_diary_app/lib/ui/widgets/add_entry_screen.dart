import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../main.dart';
import 'entries_screen.dart' show feeling2Icon;

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen();

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  dynamic _selectedFeeling = 'neutral';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        'Add New Entry',
        style: GoogleFonts.lobster(
          fontSize: 24,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      contentPadding: const EdgeInsets.all(20),
      children: [
        Form(
          key: _formKey,  
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,  
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: GoogleFonts.lobster(
                    fontSize: 20,
                  ),
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
                    child: feeling2Icon('very happy', 30),
                  ),  
                  DropdownMenuItem(
                    value: 'happy',  
                    child: feeling2Icon('happy', 30),
                  ),
                  DropdownMenuItem(
                    value: 'neutral',  
                    child: feeling2Icon('neutral', 30),
                  ),
                  DropdownMenuItem(
                    value: 'sad',  
                    child: feeling2Icon('sad', 30),
                  ),
                  DropdownMenuItem(
                    value: 'very sad',  
                    child: feeling2Icon('very sad', 30),
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
                decoration: InputDecoration(
                  labelText: 'Content',
                  labelStyle: GoogleFonts.lobster(
                    fontSize: 20,
                  ),
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
                child: Text(
                  'Add Entry',
                  style: GoogleFonts.lobster(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}