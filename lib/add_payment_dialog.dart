import 'package:flutter/material.dart';
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
  String? occurance = 'Single';
  double? amount = 0.00;

  final DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Add Payment'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                autofocus: true,
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
                onChanged: (text) => amount = double.parse(text),
              ),
              DropdownButton(
                value: occurance,
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items)
                    );
                }).toList(), 
                onChanged: (String? newValue) {
                  setState(() {
                   occurance = newValue!;
                  });
                }),
              /*RadioListTile(
                title: const Text('Recurring'),
                value: 'recurring',
                groupValue: character,
                onChanged: (value) {
                  setState(() {
                    character = (value ?? '') as String;
                  });
                },
              ),
              RadioListTile(
                title: const Text('Single'),
                value: 'single',
                groupValue: character,
                onChanged: (value) {
                  setState(() {
                    character = (value ?? '') as String;
                  });
                },
              ),
              RadioListTile(
                title: const Text('Other'),
                value: 'other',
                groupValue: character,
                onChanged: (value) {
                  setState(() {
                    character = (value ?? '') as String;
                  });
                },
              )*/
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
                if (paymentName != null && character.isNotEmpty) {
                  final newPayment =
                      Payment(paymentName!, type: character, dates: [], occurance: 'once');
                  repository.addPayment(newPayment);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add')),
        ]);
  }
}
