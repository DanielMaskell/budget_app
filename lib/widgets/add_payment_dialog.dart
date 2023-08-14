import 'package:budget_app/bloc/payment_cubit.dart';
import 'package:budget_app/repository/payment_repository.dart';
import 'package:budget_app/repository/service/payment_service.dart';
import 'package:flutter/material.dart';
import '../models/payment_hive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final PaymentRepository paymentRepository = PaymentRepository(service: PaymentService());
  TextEditingController? nameController;
  TextEditingController? descriptionController;
  TextEditingController? amountController;
  bool paymentNameError = false;
  bool paymentDescriptionError = false;
  bool amountError = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(2030),
    );
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

  bool validateInput() {
    bool valid = true;

    if (paymentName == null || paymentName!.isEmpty) {
      valid = false;
      paymentNameError = true;
    }
    if (paymentDescription == null || paymentDescription!.isEmpty) {
      valid = false;
      paymentDescriptionError = true;
    }
    if (amount == null || amount == 0.00) {
      valid = false;
      amountError = true;
    }

    return valid;
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
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: paymentNameError ? Colors.red : Colors.grey, width: 1)),
                  border: const OutlineInputBorder(),
                  hintText: 'Enter a Payment Name',
                ),
                onChanged: (text) {
                  paymentName = text;
                  paymentNameError = false;
                  setState(() {});
                },
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: paymentDescriptionError ? Colors.red : Colors.grey, width: 1)),
                  border: const OutlineInputBorder(),
                  hintText: 'Enter a description',
                ),
                onChanged: (text) {
                  paymentDescription = text;
                  paymentDescriptionError = false;
                  setState(() {});
                },
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: amountError ? Colors.red : Colors.grey, width: 1)),
                  border: const OutlineInputBorder(),
                  hintText: '0.00',
                ),
                keyboardType: TextInputType.number,
                onChanged: (String text) {
                  amount = text != '' ? double.parse(text) : 0;
                  amountError = false;
                  setState(() {});
                },
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
              onPressed: () async {
                if (validateInput()) {
                  try {
                    if (paymentName != null) {
                      final newPayment = PaymentHive(
                        id: widget.payment?.id,
                        name: paymentName!,
                        description: paymentDescription,
                        type: type,
                        date: selectedDate,
                        occurence: 'once',
                        amount: amount != null ? double.parse(amount!.toStringAsFixed(2)) : 0,
                      );
                      if (widget.editing) {
                        paymentRepository.editPayment(newPayment, widget.payment!);
                        context.read<PaymentCubit>().getPayments();
                      } else {
                        await paymentRepository.addPayment(newPayment);
                        context.read<PaymentCubit>().getPayments();
                      }

                      // widget.addPaymentCallback();
                      Navigator.of(context).pop();
                      setState(() {});
                    } else {
                      print('Payment name is null');
                    }
                  } catch (err) {
                    print('Error adding payment: $err');
                  }
                } else {
                  setState(() {});
                }
              },
              child: widget.editing ? const Text('Save') : const Text('Add')),
        ]);
  }
}
