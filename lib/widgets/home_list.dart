import 'package:budget_app/bloc/payment_cubit.dart';
import 'package:budget_app/repository/payment_repository.dart';
import 'package:budget_app/repository/service/payment_service.dart';
import 'package:budget_app/widgets/payment_list_card.dart';
import 'package:budget_app/widgets/total_calculated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_payment_dialog.dart';
import '../models/payment_hive.dart';

class HomeList extends StatefulWidget {
  const HomeList({Key? key, required this.homeListCallback}) : super(key: key);

  final void Function() homeListCallback;

  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  List<PaymentHive> monthData = [];
  GlobalKey totalCalculatorKey = GlobalKey();
  int month = 3;
  final PaymentRepository paymentRepository = PaymentRepository(service: PaymentService());
  final Map<String, int> months = {'January': 1, 'February': 2, 'March': 3, 'April': 4, 'May': 5, 'June': 6, 'July': 7, 'August': 8, 'September': 9, 'October': 10, 'November': 11, 'December': 12};

  final boldStyle = const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildHome(context);
  }

  updateMonthData(int? newMonth, List<PaymentHive> payments) {
    List<PaymentHive> tempList = [];
    monthData = [];

    for (PaymentHive p in payments) {
      if (p.amount < 0) tempList.add(p);
    }
    tempList.sort(((a, b) => b.compareTo(a)));

    for (PaymentHive item in tempList) {
      if (item.date.month == month) {
        monthData.add(item);
      }
    }
  }

  removePaymentCallback(PaymentHive payment) async {
    await paymentRepository.removePayment(payment);
    context.read<PaymentCubit>().getPayments();
    setState(() {});
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
    return BlocBuilder<PaymentCubit, PaymentState>(builder: (context, state) {
      updateMonthData(null, state.payments);
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: DropdownButton<int>(
                value: month,
                items: months
                    .map((name, value) {
                      return MapEntry(
                        name,
                        DropdownMenuItem<int>(
                          value: value,
                          child: Text(name),
                        ),
                      );
                    })
                    .values
                    .toList(),
                onChanged: ((value) {
                  updateMonthData(value as int, state.payments);
                  setState(() {
                    month = value;
                  });
                }),
              ),
            ),
            Expanded(
              flex: 10,
              child: ListView(
                padding: const EdgeInsets.all(4),
                children: monthData.isNotEmpty
                    ? monthData
                        // .map((e) => ListTile(title: Text(e.name)))
                        // .map((p) => ListTile(title: Text(p.name)))
                        /*.map((p) => PaymentTile(
                          payment: p,
                        ))
                    .toList(),*/
                        .map((p) => PaymentListCard(
                              // id: p.id,
                              payment: p,
                              removePaymentCallback: removePaymentCallback,
                              editPaymentCallback: editPaymentCallback,
                            ))
                        .toList()
                    : [],
                shrinkWrap: true,
              ),
            ),
            Expanded(
              flex: 1,
              child: TotalCalculator(
                key: totalCalculatorKey,
                payments: monthData,
              ),
            ),
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
    });
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
