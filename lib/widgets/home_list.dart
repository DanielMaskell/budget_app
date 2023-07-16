import 'package:budget_app/bloc/payment_cubit.dart';
import 'package:budget_app/repository/payment_repository.dart';
import 'package:budget_app/widgets/payment_list_card.dart';
import 'package:budget_app/widgets/total_calculated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  // final PaymentRepository paymentRepository = PaymentRepository();
  // late final Map<dynamic, PaymentHive> payments = paymentRepository.getBox();
  // late Box<PaymentHive> paymentBox;
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

  final boldStyle =
      const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    // paymentBox = Hive.box<PaymentHive>('paymentBoxTest');
    // updateMonthData(month);
  }

  @override
  Widget build(BuildContext context) {
    return _buildHome(context);
  }

  updateMonthData(int? newMonth, List<PaymentHive> payments) {
    List<PaymentHive> tempList = [];
    monthData = [];

    // paymentBox.toMap().forEach((key, value) {
    //   PaymentHive tempItem = PaymentHive(
    //     name: value.name,
    //     type: value.type,
    //     date: value.date,
    //     occurence: value.occurence,
    //     amount: value.amount,
    //   );
    //   tempList.add(tempItem);
    // });
    for (PaymentHive p in payments) {
      PaymentHive tempItem = PaymentHive(
        name: p.name,
        type: p.type,
        date: p.date,
        occurence: p.occurence,
        amount: p.amount,
      );
      tempList.add(tempItem);
    }
    tempList.sort(((a, b) => b.compareTo(a)));

    for (PaymentHive item in tempList) {
      if (item.date.month == month) {
        monthData.add(item);
      }
    }
    // setState(() {});
  }

  removePaymentCallback(PaymentHive payment, int id) {
    // paymentRepository.removePayment(payment, id);
    // updateMonthData(month);
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
      // updateMonthData(month, state.payments);
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
                          ));
                    })
                    .values
                    .toList(),
                onChanged: ((value) {
                  updateMonthData(value as int, state.payments);
                  setState(() {
                    month = value as int;
                  });
                }),
              ),
            ),

            // SingleChildScrollView(
            //   child: Column(
            Expanded(
              flex: 10,
              child: ListView(
                padding: const EdgeInsets.all(4),
                // itemCount: state.payments.length,
                // sepakratorBuilder: (_, __) => const Divider(),
                // itemBuilder: (context, int index) {
                //   return ListTile(
                //     title: Text(state.payments[index].name),
                //   );
                // },
                // children: state.payments
                //     .map((e) => ListTile(title: Text(e.name)))
                //     .toList(),
                children: monthData
                    .map((e) => ListTile(title: Text(e.name)))
                    .toList(),
                shrinkWrap: true,
              ),
            ),
            // SizedBox(
            //   height: 500,
            //   child: ListView(
            //     padding: const EdgeInsets.all(4),
            //     // itemCount: state.payments.length,
            //     // sepakratorBuilder: (_, __) => const Divider(),
            //     // itemBuilder: (context, int index) {
            //     //   return ListTile(
            //     //     title: Text(state.payments[index].name),
            //     //   );
            //     // },
            //     children: state.payments
            //         .map((e) => ListTile(title: Text(e.name)))
            //         .toList(),
            //     shrinkWrap: true,
            //   ),
            // ),

            // ),

            // ValueListenableBuilder(
            //   // valueListenable: paymentBox.listenable(),
            //   valueListenable: state.payments.listenable(),
            //   builder: (context, Box<PaymentHive> payments, _) {
            //     List<PaymentHive> paymentsList = [];
            //     paymentsList = payments.values
            //         .where((element) => element.date.month == month)
            //         .toList();
            //     paymentsList.sort();
            //     return Flexible(
            //       flex: 4,
            //       child: ListView.separated(
            //         separatorBuilder: (_, index) => const Divider(
            //           height: 10.0,
            //         ),
            //         itemCount: paymentsList.length,
            //         itemBuilder: (_, index) {
            //           final PaymentHive? data =
            //               paymentsList.isNotEmpty ? paymentsList[index] : null;

            //           return PaymentListCard(
            //             payment: data,
            //             removePaymentCallback: removePaymentCallback,
            //             id: index,
            //             editPaymentCallback: editPaymentCallback,
            //           );
            //         },
            //       ),
            //     );
            //   },
            // ),
            Expanded(
                flex: 1,
                child: TotalCalculator(
                  key: totalCalculatorKey,
                  payments: monthData,
                ))
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
