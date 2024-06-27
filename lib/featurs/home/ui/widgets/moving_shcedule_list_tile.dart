import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moveassist/featurs/home/data/models/moving_schedule.dart';

class MovingScheduleListTile extends StatelessWidget {
  const MovingScheduleListTile({
    super.key,
    required this.schedule,
  });

  final MovingSchedule schedule;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          'Schedule for ${DateFormat('yyyy-MM-dd HH:mm:ss').format(schedule.date)}'),
      subtitle: Text(schedule.notes),
    );
  }
}
