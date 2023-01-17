import 'package:budget_app/repository/payment_repository.dart';
import 'package:budget_app/widgets/total_calculated.dart';
import 'package:flutter/material.dart';
import '../add_payment_dialog.dart';
import '../models/payment_hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeList extends StatefulWidget {
  const HomeList({Key? key, required this.homeListCallback}) : super(key: key);

  final void Function() homeListCallback;
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  final PaymentRepository paymentRepository = PaymentRepository();
  late final Map<dynamic, PaymentHive> payments = paymentRepository.getBox();
  late Box<PaymentHive> paymentBox;
  GlobalKey totalCalculatorKey = GlobalKey();

  final boldStyle =
      const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
  @override
  void initState() {
    super.initState();
    paymentBox = Hive.box<PaymentHive>('paymentBoxTest');
  }

  @override
  Widget build(BuildContext context) {
    return _buildHome(context);
  }

  Widget _buildHome(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder(
            valueListenable: paymentBox.listenable(),
            builder: (context, Box<PaymentHive> payments, _) {
              List<int> keys = payments.keys.cast<int>().toList();
              return Flexible(
                flex: 4,
                child: ListView.separated(
                  separatorBuilder: (_, index) => const Divider(
                    height: 10.0,
                  ),
                  itemCount: keys.length,
                  itemBuilder: (_, index) {
                    final int key = keys[index];
                    final PaymentHive? data = payments.get(key);
                    return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        color: Colors.grey,
                        child: ListTile(
                          title: Text(
                            data!.name,
                          ),
                          subtitle: Text(data.amount.toString()),
                        ));
                  },
                ),
              );
            },
          ),
          TotalCalculator(
            key: totalCalculatorKey,
            payments: payments,
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
    print('check1 addPaymentCallback called');
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
