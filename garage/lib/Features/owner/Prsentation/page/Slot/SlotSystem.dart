import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/Features/owner/Prsentation/bloc/Slot_bloc/bloc/slot_bloc.dart';
import 'package:garage/Features/owner/Prsentation/page/OwnerDashbord/OwnerPages.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';
import 'package:intl/intl.dart';

//  context.read<PaymentBloc>().add(  );

class DateTimePicker extends StatefulWidget {
  final DateTime fetchedDateTime;

  DateTimePicker({required this.fetchedDateTime});

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.fetchedDateTime;
  }

  Future<void> _pickDate() async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = now;
    final DateTime lastDate = initialDate.add(Duration(days: 0));

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      barrierColor: Kcolor.primary,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      _pickTime(pickedDate);
    }
  }

  Future<void> _pickTime(DateTime pickedDate) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      barrierColor: Kcolor.primary,
      context: context,
      initialTime: TimeOfDay(hour: 8, minute: 0),
    );

    if (pickedTime != null) {
      final DateTime pickedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      final DateTime now = DateTime.now();
      final DateTime initialDate = now;
      final DateTime limitDate = initialDate.add(Duration(days: 2));

      if (pickedDateTime.isBefore(initialDate) ||
          pickedDateTime.isAfter(limitDate) ||
          pickedTime.hour < 8 ||
          pickedTime.hour >= 21) {
        InvvalidSelectionDialog(ChooseTime: pickedDateTime);
      } else {
        context.read<SlotBloc>().add(AddSlotRequested(pickedDateTime));
        setState(() {
          _selectedDateTime = pickedDateTime;
        });
      }
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.info,
                size: 25,
                color: Kcolor.button,
              ), // Icon
              Text('Invalid Time'),
            ],
          ),
          content: Text('Please select a time between 8 AM and 9 PM And .'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SlotBloc, SlotState>(
      listener: (context, state) {
        if (state is SlotAddSucsess) {
          Slot_Add_Sucess_Dialog();
        }
      },
      child: Column(
        children: [
          ElevatedButton(
            onPressed: _pickDate,
            style: ElevatedButton.styleFrom(
              backgroundColor: Kcolor.button,
              shadowColor: Kcolor.button,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
            ),
            child: Text('ADD',
                style:
                    TextStyle(color: Kcolor.bg, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,

                    child: Icon(
                      Icons.info,
                      size: 18,
                      color: Kcolor.button,
                    ), // Icon on the left side
                  ),
                  TextSpan(
                    text: ' Last Slot Date:',
                    style: TextStyle(
                      color: Kcolor.TextB,
                      fontFamily: fontstyles.Gpop,
                      fontWeight: FontWeight.w200,
                      fontSize: 10,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' ${DateFormat('yyyy-MM-dd').format(_selectedDateTime)}',
                    style: TextStyle(
                      color: Kcolor.TextB,
                      fontFamily: fontstyles.Gpop,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  TextSpan(
                    text: ' And',
                    style: TextStyle(
                      color: Kcolor.TextB,
                      fontFamily: fontstyles.Gpop,
                      fontWeight: FontWeight.w200,
                      fontSize: 10,
                    ),
                  ),
                  TextSpan(
                    text: ' Time: ',
                    style: TextStyle(
                      color: Kcolor.TextB,
                      fontFamily: fontstyles.Gpop,
                      fontWeight: FontWeight.w200,
                      fontSize: 10,
                    ),
                  ),
                  TextSpan(
                    text: '${DateFormat('hh:mm a').format(_selectedDateTime)}',
                    style: TextStyle(
                      color: Kcolor.TextB,
                      fontFamily: fontstyles.Gpop,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  TextSpan(
                    text:
                        '. Please select a date and time after the given slot',
                    style: TextStyle(
                      color: Kcolor.TextB,
                      fontFamily: fontstyles.Gpop,
                      fontWeight: FontWeight.w200,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
