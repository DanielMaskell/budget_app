import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'repository/data_repository.dart';
import 'models/payment.dart';
import 'add_date.dart';
import 'date_list.dart';
import 'widgets/text_field.dart';
import 'models/date.dart';
import 'widgets/choose_chips.dart';

class PaymentDetail extends StatefulWidget {
  final Payment payment;

  const PaymentDetail({Key? key, required this.payment}) : super(key: key);

  @override
  _PaymentDetailState createState() => _PaymentDetailState();
}

class _PaymentDetailState extends State<PaymentDetail> {
  final DataRepository repository = DataRepository();
  final _formKey = GlobalKey<FormState>();
  final dateFormat = DateFormat('yyyy-MM-dd');
  late List<CategoryOption> paymentTypes;
  late String name;
  late String type;
  String? description;

  @override
  void initState() {
    type = widget.payment.type;
    name = widget.payment.name;
    paymentTypes = [
      CategoryOption(
          type: 'recurring',
          name: 'Recurring',
          isSelected: type == 'recurring'),
      CategoryOption(
          type: 'single', name: 'Single', isSelected: type == 'single'),
      CategoryOption(type: 'other', name: 'Other', isSelected: type == 'other'),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      height: double.infinity,
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              UserTextField(
                name: 'Payment Name',
                initialValue: widget.payment.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please input name';
                  }
                },
                inputType: TextInputType.name,
                onChanged: (value) => name = value ?? name,
              ),
              ChooseType(
                title: 'Payment Type',
                options: paymentTypes,
                onOptionTap: (value) {
                  setState(() {
                    paymentTypes.forEach((element) {
                      type = value.type;
                      element.isSelected = element.type == value.type;
                    });
                  });
                },
              ),
              const SizedBox(height: 20.0),
              UserTextField(
                name: 'notes',
                initialValue: widget.payment.description ?? '',
                validator: (value) {},
                inputType: TextInputType.text,
                onChanged: (value) => description = value,
              ),
              DateList(payment: widget.payment, buildRow: buildRow),
              FloatingActionButton(
                onPressed: () {
                  _addDate(widget.payment, () {
                    setState(() {});
                  });
                },
                tooltip: 'Add Payment',
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                      color: Colors.blue.shade600,
                      onPressed: () {
                        Navigator.of(context).pop();
                        repository.deletePayment(widget.payment);
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      )),
                  MaterialButton(
                    color: Colors.blue.shade600,
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.of(context).pop();
                        widget.payment.name = name;
                        widget.payment.type = type;
                        widget.payment.description =
                            description ?? widget.payment.description;

                        repository.updatePayment(widget.payment);
                      }
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRow(Date date) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(date.name),
        ),
        Text(dateFormat.format(date.date)),
        Checkbox(
          value: date.done ?? false,
          onChanged: (newValue) {
            setState(() {
              date.done = newValue;
            });
          },
        )
      ],
    );
  }

  void _addDate(Payment payment, Function callback) {
    showDialog<Widget>(
        context: context,
        builder: (BuildContext context) {
          return AddDate(payment: payment, callback: callback);
        });
  }
}
