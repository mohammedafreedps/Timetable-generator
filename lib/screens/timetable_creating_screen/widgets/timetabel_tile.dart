import 'package:flutter/material.dart';
import 'package:ttg/models/timetable_entry_model.dart';

Widget timeTableTile(List<TimeTableEntryModel> timeTableModel) {
  Map<String, List<TimeTableEntryModel>> groupedByDay = {};
  for (var entry in timeTableModel) {
    groupedByDay.putIfAbsent(entry.day, () => []).add(entry);
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: groupedByDay.entries.map((dayEntry) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Day Header
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              dayEntry.key,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...dayEntry.value.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.subject,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    entry.time,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    entry.tutor,
                    style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          }),
        ],
      );
    }).toList(),
  );
}
