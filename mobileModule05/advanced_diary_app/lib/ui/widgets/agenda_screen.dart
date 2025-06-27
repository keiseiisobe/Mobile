import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'add_entry_screen.dart';
import '../view_model/agenda_viewmodel.dart';
import '../../main.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  final _stream = db.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('entries').orderBy('timestamp', descending: true).snapshots();
  var focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,  
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Agenda',
        style: GoogleFonts.lobster(
            fontSize: 24,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_profile.png'),
            fit: BoxFit.cover,
          ),
        ),  
        child: StreamBuilder(
          stream: _stream,
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (asyncSnapshot.hasError) {
              return Center(child: Text('Error: ${asyncSnapshot.error}'));
            }  
            var data = asyncSnapshot.data!.docs;
            return Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.now().subtract(const Duration(days: 365 * 10)),
                  lastDay: DateTime.now().add(const Duration(days: 365 * 10)),
                  focusedDay: focusedDay,
                  calendarFormat: CalendarFormat.month,
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: GoogleFonts.lobster(
                      fontSize: 20,
                      color: Colors.white,
                    ),  
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: GoogleFonts.lobster(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    weekendStyle: GoogleFonts.lobster(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    defaultTextStyle: GoogleFonts.lobster(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    weekendTextStyle: GoogleFonts.lobster(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    outsideTextStyle: GoogleFonts.lobster(
                      fontSize: 16,
                      color: Colors.white30,
                    ),
                  ),
                  eventLoader: (day) {
                    return getEventsForDay(day, data, context);
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(focusedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      this.focusedDay = focusedDay;
                    });  
                  },
                ),
                Expanded(
                  child: ListView(
                    children: getEventsForDay(focusedDay, data, context),
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
          }
        ),
      ),
    );
  }
}