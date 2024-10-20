import 'package:flutter/material.dart';
import 'package:ttg/models/timetable_entry_model.dart';

class EditEntryDialog extends StatefulWidget {
  final TimeTableEntryModel entry;

  const EditEntryDialog({Key? key, required this.entry}) : super(key: key);

  @override
  _EditEntryDialogState createState() => _EditEntryDialogState();
}

class _EditEntryDialogState extends State<EditEntryDialog> {
  late String subject;
  late String tutor;
  late String time;

  @override
  void initState() {
    super.initState();
    subject = widget.entry.subject;
    tutor = widget.entry.tutor;
    time = widget.entry.time;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Timetable Entry for ${widget.entry.day}'), // Show the day in the title
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Subject'),
            controller: TextEditingController(text: subject),
            onChanged: (value) => subject = value,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Tutor'),
            controller: TextEditingController(text: tutor),
            onChanged: (value) => tutor = value,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Time'),
            controller: TextEditingController(text: time),
            onChanged: (value) => time = value,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog without saving
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Create a new entry with the updated information
            final updatedEntry = TimeTableEntryModel(
              courseName: widget.entry.courseName,
              day: widget.entry.day, // Keep the original day
              subject: subject,
              tutor: tutor,
              time: time,
            );

            Navigator.of(context).pop(updatedEntry); // Return the updated entry
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
