import 'package:budget_app/repository/payment_repository.dart';
import 'package:budget_app/widgets/paymentListCard.dart';
import 'package:budget_app/widgets/total_calculated.dart';
import 'package:flutter/material.dart';
import 'add_payment_dialog.dart';
import '../models/payment_hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeList extends StatefulWidget {
  const HomeList({Key? key, required this.homeListCallback}) : super(key: key);

  final void Function() homeListCallback;

  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  List<PaymentHive> monthData = [];
  final PaymentRepository paymentRepository = PaymentRepository();
  late final Map<dynamic, PaymentHive> payments = paymentRepository.getBox();
  late Box<PaymentHive> paymentBox;
  GlobalKey totalCalculatorKey = GlobalKey();
  int month = 3;
  final Map<String, int> months = {
    'January': 1,
    'February': 2,
    'March': 3,
    'April': 4,
    'May': 5,
    'June': 6,
    'July': 7,
    'August': 8,
    'September': 9,
    'October': 10,
    'November': 11,
    'December': 12
  };

  final boldStyle = const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    paymentBox = Hive.box<PaymentHive>('paymentBoxTest');
    updateMonthData(month);
  }

  @override
  Widget build(BuildContext context) {
    return _buildHome(context);
  }

  updateMonthData(int newMonth) {
    List<PaymentHive> tempList = [];
    monthData = [];

    paymentBox.toMap().forEach((key, value) {
      PaymentHive tempItem = PaymentHive(
        name: value.name,
        type: value.type,
        date: value.date,
        occurence: value.occurence,
        amount: value.amount,
      );
      tempList.add(tempItem);
    });
    tempList.sort(((a, b) => b.compareTo(a)));

    for (PaymentHive item in tempList) {
      if (item.date.month == month) {
        monthData.add(item);
      }
    }
    setState(() {});
  }

  removePaymentCallback(PaymentHive payment, int id) {
    paymentRepository.removePayment(payment, id);
    updateMonthData(month);
  }

  void editPaymentCallback({PaymentHive? payment, int? id}) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AddPaymentDialog(
          editing: true,
          payment: payment,
          id: id,
          addPaymentCallback: addPaymentCallback,
        );
      },
    );
  }

  Widget _buildHome(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButton<int>(
            value: month,
            items: months
                .map((name, value) {
                  return MapEntry(
                      name,
                      DropdownMenuItem<int>(
                        value: value,
                        child: Text(name),
                      ));
                })
                .values
                .toList(),
            onChanged: ((value) {
              setState(() {
                month = value as int;
              });
              updateMonthData(value as int);
            }),
          ),
          ValueListenableBuilder(
            valueListenable: paymentBox.listenable(),
            builder: (context, Box<PaymentHive> payments, _) {
              List<PaymentHive> paymentsList = [];
              paymentsList = payments.values.where((element) => element.date.month == month).toList();
              paymentsList.sort();
              return Flexible(
                flex: 4,
                child: ListView.separated(
                  separatorBuilder: (_, index) => const Divider(
                    height: 10.0,
                  ),
                  itemCount: paymentsList.length,
                  itemBuilder: (_, index) {
                    final PaymentHive? data = paymentsList.isNotEmpty ? paymentsList[index] : null;

                    return PaymentListCard(
                      payment: data,
                      removePaymentCallback: removePaymentCallback,
                      id: index,
                      editPaymentCallback: editPaymentCallback,
                    );
                  },
                ),
              );
            },
          ),
          TotalCalculator(
            key: totalCalculatorKey,
            payments: monthData,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addPayment();
        },
        tooltip: 'Add Payment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void addPaymentCallback() {
    widget.homeListCallback();
    setState(() {
      totalCalculatorKey = GlobalKey();
    });
  }

  void _addPayment() {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return AddPaymentDialog(
          addPaymentCallback: addPaymentCallback,
        );
      },
    );
  }
}
