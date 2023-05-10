import 'package:budget_app/repository/payment_repository.dart';
// import 'package:budget_app/widgets/date_picker.dart';
import 'package:flutter/material.dart';
// import '../models/date.dart';
// import '../models/payment.dart';
import '../models/payment_hive.dart';
import '../repository/data_repository.dart';
// import 'package:hive/hive.dart';

class AddPaymentDialog extends StatefulWidget {
  const AddPaymentDialog({
    Key? key,
    required this.addPaymentCallback,
    this.editing = false,
    this.payment,
    this.id,
  }) : super(key: key);

  final void Function() addPaymentCallback;
  final bool editing;
  final PaymentHive? payment;
  final int? id;

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
  double? amount = 0.00;
  String type = 'Power';
  late DateTime selectedDate;
  String frequency = 'Weekly';
  List<String> frequencies = ['Weekly', 'Fortnightly', 'Monthly'];
  final DataRepository repository = DataRepository();
  final PaymentRepository paymentRepository = PaymentRepository();
  TextEditingController? nameController;
  TextEditingController? descriptionController;
  TextEditingController? amountController;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked =
        await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(2020, 1), lastDate: DateTime(2030));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    selectedDate = widget.payment != null ? widget.payment!.date : DateTime.now();
    paymentName = widget.payment != null ? widget.payment!.name : '';
    nameController = TextEditingController(text: widget.payment?.name);
    descriptionController = TextEditingController(text: widget.payment?.description);
    amountController = TextEditingController(text: widget.payment?.amount.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: widget.editing ? const Text('Edit Payment') : const Text('Add Payment'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: nameController,
                // autofocus: true,
                decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Enter a Payment Name'),
                onChanged: (text) => paymentName = text,
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a description',
                ),
                onChanged: (text) => paymentDescription = text,
              ),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '0.00',
                ),
                keyboardType: TextInputType.number,
                onChanged: (String? text) => amount = text != null ? double.parse(text) : 0,
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
                    final newPayment = PaymentHive(
                      name: paymentName!,
                      description: paymentDescription,
                      type: type,
                      date: selectedDate,
                      occurence: 'once',
                      amount: amount != null ? double.parse(amount!.toStringAsFixed(2)) : 0,
                    );
                    if (widget.editing) {
                      paymentRepository.editPayment(newPayment, widget.id!, widget.payment!);
                    } else {
                      paymentRepository.addPayment(newPayment);
                    }

                    widget.addPaymentCallback();
                    Navigator.of(context).pop();
                  } else {
                    print('Payment name is null');
                  }
                } catch (err) {
                  print('Error adding payment: $err');
                }
              },
              child: widget.editing ? const Text('Save') : const Text('Add')),
        ]);
  }
}
