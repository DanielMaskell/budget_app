import 'package:budget_app/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'models/date.dart';
import 'models/payment.dart';
import 'repository/data_repository.dart';

class AddPaymentDialog extends StatefulWidget {
  const AddPaymentDialog({Key? key}) : super(key: key);

  @override
  _AddPaymentDialogState createState() => _AddPaymentDialogState();
}

class _AddPaymentDialogState extends State<AddPaymentDialog> {
  String? paymentName;
  String character = '';
  String? paymentDescription;
  List<String> items = ['Recurring', 'Single'];
  List<String> types = ['Power', 'water'];
  String? occurence = 'Single';
  double amount = 0.00;
  String type = 'Power';
  DateTime selectedDate = DateTime.now();
  String frequency = 'Weekly';
  List<String> frequencies = ['Weekly', 'Fortnightly', 'Monthly'];

  final DataRepository repository = DataRepository();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime(2030));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  /*DropdownButton _frequencyPicker (BuildContext context){
    /*return DropdownButton(
                value: frequency,
                items: frequencies.map((String frequencies){
                  return DropdownMenuItem(
                    value: frequencies,
                    child: Text(frequencies),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    frequency = newValue!;
                  });
                }
              ),*/
  }*/

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Add Payment'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                // autofocus: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a Payment Name'),
                onChanged: (text) => paymentName = text,
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a description',
                ),
                onChanged: (text) => paymentDescription = text,
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '0.00',
                ),
                keyboardType: TextInputType.number,
                onChanged: (text) => amount = double.parse(text),
              ),
              DropdownButton(
                  value: occurence,
                  items: items.map((String items) {
                    return DropdownMenuItem(value: items, child: Text(items));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      occurence = newValue!;
                    });
                  }),
              Container(
                child: occurence == 'Recurring'
                    ? DropdownButton(
                        value: frequency,
                        items: frequencies.map((String frequencies) {
                          return DropdownMenuItem(
                            value: frequencies,
                            child: Text(frequencies),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            frequency = newValue!;
                          });
                        })
                    : Container(),
              ),
              DropdownButton(
                  value: type,
                  items: types.map((String types) {
                    return DropdownMenuItem(
                      value: types,
                      child: Text(types),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      type = newValue!;
                    });
                  }),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text('$selectedDate'),
              )
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                try {
                  if (paymentName != null) {
                    List<DateTime> tempDates = [];
                    if (occurence == 'Single') {
                      print('occurence true');
                      tempDates.add(selectedDate);
                    }

                    final newPayment = Payment(paymentName!,
                        type: type,
                        dates: tempDates,
                        occurence: 'once',
                        amount: amount);
                    repository.addPayment(newPayment);
                    Navigator.of(context).pop();
                  }
                } catch (err) {
                  print('Error adding payment: $err');
                }
              },
              child: const Text('Add')),
        ]);
  }
}
