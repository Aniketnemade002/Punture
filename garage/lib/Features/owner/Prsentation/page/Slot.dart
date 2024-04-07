import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// to Sort Slot
// slots.sort((a, b) => a['SlotNo'].compareTo(b['SlotNo']));

Future<Timestamp> chooseTimeAndConvertToTimestamp(BuildContext context) async {
  // Show time picker
  TimeOfDay? selectedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (selectedTime != null) {
    // Convert chosen time to DateTime
    DateTime now = DateTime.now();
    DateTime chosenDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    // Convert DateTime to Firestore timestamp
    return Timestamp.fromDate(chosenDateTime);
  } else {
    // Return null if time picker is dismissed
    return Timestamp.now(); // or return current timestamp
  }
}

class TimeSlot {
  final dateTime;
  final int slotId;

  TimeSlot({required this.dateTime, required this.slotId});

  Map<String, dynamic> toJson() {
    return {
      'dateTime': dateTime,
      'slotId': slotId,
    };
  }
}

class TimeSlotScreen extends StatefulWidget {
  @override
  _TimeSlotScreenState createState() => _TimeSlotScreenState();
}

class _TimeSlotScreenState extends State<TimeSlotScreen> {
  List<TimeSlot> _timeSlots = [];

  Future<void> _addTimeSlot(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
          Duration(days: 365)), // Allow selecting dates up to 1 year from today
    );

    if (selectedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        DateTime selectedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Check if selected date is not yesterday
        if (!selectedDateTime
            .isBefore(DateTime.now().subtract(Duration(days: 1)))) {
          // Check if selected date and time are not already chosen
          if (!_isDateTimeAlreadyChosen(selectedDateTime)) {
            // Check if selected time is after the last slot time
            if (_timeSlots.isNotEmpty &&
                selectedDateTime.isBefore(_timeSlots.last.dateTime)) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Please choose a time after ${_timeSlots.last.dateTime.hour}:${_timeSlots.last.dateTime.minute}'),
                ),
              );
            } else {
              TimeSlot newTimeSlot = TimeSlot(
                dateTime: selectedDateTime,
                slotId: _timeSlots.isNotEmpty ? _timeSlots.last.slotId + 1 : 1,
              );

              setState(() {
                _timeSlots.add(newTimeSlot);
              });
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'Time slot already chosen. Please choose another time.'),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please choose a date starting from today.'),
            ),
          );
        }
      }
    }
  }

  bool _isDateTimeAlreadyChosen(DateTime dateTime) {
    return _timeSlots.any((timeSlot) => timeSlot.dateTime == dateTime);
  }

  void _deleteTimeSlot(TimeSlot timeSlot) {
    setState(() {
      _timeSlots.remove(timeSlot);
    });
  }

  Future<void> _saveTimeSlots() async {
    // Convert list of TimeSlot objects to JSON
    List<Map<String, dynamic>> timeSlotsJson =
        _timeSlots.map((timeSlot) => timeSlot.toJson()).toList();

    // Save the JSON to Firestore or wherever you need
    String jsonString = json.encode(timeSlotsJson);
    print(jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Slot Example'),
        actions: [
          IconButton(
            onPressed: _saveTimeSlots,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _timeSlots.length,
              itemBuilder: (context, index) {
                final timeSlot = _timeSlots[index];
                return ListTile(
                  title: Text('Slot ${timeSlot.slotId}'),
                  subtitle: Text(
                      'Date: ${timeSlot.dateTime.toLocal().toString().split(' ')[0]} '
                      'Time: ${timeSlot.dateTime.hour}:${timeSlot.dateTime.minute}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteTimeSlot(timeSlot),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTimeSlot(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
