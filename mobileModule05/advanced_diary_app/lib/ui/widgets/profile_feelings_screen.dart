import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'entries_screen.dart';
import '../../main.dart';

class ProfileFeelingsScreen extends StatefulWidget {
  const ProfileFeelingsScreen({
    super.key,
  });

  @override
  State<ProfileFeelingsScreen> createState() => _ProfileFeelingsScreenState();
}

class _ProfileFeelingsScreenState extends State<ProfileFeelingsScreen> {
  final _stream = db.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('entries').snapshots();

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
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildFeelingsOverview(data),
          )
        );
      },
    );
  }

  List<ListTile>  _buildFeelingsOverview(List data) {
    var feelings = [
      {
        'feeling': 'very happy',
        'title': 'Joy Ascendant',
        'subtitle': 'A Heart\'s Merry Dance, a Soul\'s Bright Dawn',
        'percentage': _getFeelingPercentage(data, 'very happy').toStringAsFixed(1),
      },
      {
        'feeling': 'happy',
        'title': 'Sweet Contentment',
        'subtitle': 'A Gentle Smile, a Peaceful Ease',
        'percentage': _getFeelingPercentage(data, 'happy').toStringAsFixed(1),
      },
      {
        'feeling': 'neutral',
        'title': 'Calm Equanimity',
        'subtitle': 'A Still Lake, a Balanced Scale',
        'percentage': _getFeelingPercentage(data, 'neutral').toStringAsFixed(1),
      },
      {
        'feeling': 'sad',
        'title': 'Sorrow\'s Shadow',
        'subtitle': 'A Heavy Heart, a Lingering Sigh',
        'percentage': _getFeelingPercentage(data, 'sad').toStringAsFixed(1),
      },
      {
        'feeling': 'very sad',
        'title': 'Profound Lament',
        'subtitle': 'A Soul\'s Deep Woe, a Cry from the Abyss',
        'percentage': _getFeelingPercentage(data, 'very sad').toStringAsFixed(1),
      },
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
        trailing: Text(
          "${feeling['percentage']}%",
          style: GoogleFonts.lobster(
            color: _feeling2Color(feeling['feeling']!),
            fontSize: 16,
          )
        ),
      );
    }).toList();  
  }

  double _getFeelingPercentage(List data, String feeling) {
    var length = data.length;  
    int count = 0;
    for (var d in data) {
      if (d['feeling'] == feeling) {
        count++;  
      }
    }
    return count / length * 100;
  }

  Color _feeling2Color(String feeling) {
    switch (feeling) {
      case 'very happy':
        return Colors.red;
      case 'happy':
        return Colors.orange;
      case 'sad':
        return Colors.blue;
      case 'very sad':
        return Colors.purple;
      default:
        return Colors.green;
    }
  }  
}