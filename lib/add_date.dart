import 'dart:io';

import 'package:flutter/material.dart';

import 'models/payment.dart';
import 'widgets/text_field.dart';
import 'models/date.dart';
import 'widgets/date_picker.dart';
import 'widgets/done_check_box.dart';

class AddDate extends StatefulWidget {
  final Payment payment;
  final Function callback;
  const AddDate({Key? key, required this.payment, required this.callback})
      : super(key: key);
  @override
  _AddDateState createState() => _AddDateState();
}

class _AddDateState extends State<AddDate> {
  final _formKey = GlobalKey<FormState>();

  late Payment payment;
  var done = false;
  var dateName = '';
  late DateTime date;

  @override
  void initState() {
    payment = widget.payment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Date'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: <Widget>[
                UserTextField(
                  name: 'date',
                  initialValue: '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the date Name';
                    }
                  },
                  inputType: TextInputType.text,
                  onChanged: (value) {
                    if (value != null) {
                      dateName = value;
                    }
                  },
                ),
                DatePicker(
                    name: 'Date',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the Date';
                      }
                    },
                    onChanged: (text) {
                      date = text;
                    }),
                DoneCheckBox(
                    name: 'Done',
                    value: done,
                    onChanged: (text) {
                      done = text ?? done;
                    }),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  Navigator.of(context).pop();
                  final newDate = Date(dateName, date: date, done: done);
                  payment.dates.add(newDate);
                }
                widget.callback();
              },
              child: const Text('Add')),
        ]);
  }
}
