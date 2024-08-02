import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CanlendarScreen extends StatelessWidget {
  const CanlendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
        ),
      ],
    ));
  }
}
