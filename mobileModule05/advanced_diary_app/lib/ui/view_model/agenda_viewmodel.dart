import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:google_fonts/google_fonts.dart";
import "../widgets/entries_screen.dart";
import "../widgets/entry_detail_screen.dart";

List<Widget> getEventsForDay(DateTime day, List data, BuildContext context) {
  List<Widget> events = [];  
  for (var entry in data) {
    DateTime entryDate = entry['timestamp'].toDate();
    if (entryDate.year == day.year && entryDate.month == day.month && entryDate.day == day.day) {
      events.add(
        ListTile(
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
          },
        ),
      );
    }
  }
  return events;
}