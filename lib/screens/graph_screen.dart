import 'package:flutter/material.dart';
import 'package:budget_app/widgets/drawer.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:budget_app/repository/payment_repository.dart';
import '../models/payment_hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({
    Key? key,
    }) : super(key: key);

    static const String routeName = '/graphscreen';

    @override 
    _GraphScreen createState() => _GraphScreen();
}

class _GraphScreen extends State<GraphScreen> {

  // List<_BudgetData> data = [
  //   _BudgetData('Jan', 35),
  //   _BudgetData('Feb', 28),
  //   _BudgetData('Mar', 34),
  //   _BudgetData('Apr', 32),
  //   _BudgetData('May', 40)
  // ];

  List<_BudgetData> tempList = [];
  final PaymentRepository paymentRepository = PaymentRepository();
  late final Map<dynamic, PaymentHive> payments = paymentRepository.getBox();
  late Box<PaymentHive> paymentBox;

  @override 
  void initState() {
    super.initState();
    paymentBox = Hive.box<PaymentHive>('paymentBoxTest');
    print('check2 grpah screen init');
  }

  @override 
  Widget build(BuildContext context) {

    double total = 0;
    int counter = 0;
    paymentBox.toMap().forEach((key, value) {
      total = total + value.amount;
      DateTime tempDate = DateTime(value.date.year, value.date.month, value.date.day);
      _BudgetData tempItem = _BudgetData(DateTime.tryParse(DateFormat('yyyy-MM-dd').format(tempDate)), total);
      tempList.add(tempItem);
      counter++;
    });

    print('check2 counter: $counter');
    // for(int i=0;i<paymentBox.length;i++){
    //   paymentBox.keys.map((e) => null)
    // }
    /*for(int i=0;i<data.length;i++){
      total = total + data[i].amount;
      _BudgetData tempItem = _BudgetData(data[i].month, total);
      tempList.add(tempItem);
    } */

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
      ),
      drawer: SafeArea(child: AppDrawer()),
      body: Center(
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          title: ChartTitle(text: 'Test Chart'),
          legend: Legend(isVisible: true),
          series: <ChartSeries<_BudgetData, String>>[
                LineSeries<_BudgetData, String>(
                    dataSource: tempList,
                    xValueMapper: (_BudgetData sales, _) => sales.date.toString(),
                    yValueMapper: (_BudgetData sales, _) => sales.amount,
                    name: 'Sales',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true))
        ])
      )
    );
  }
}

class _BudgetData {
  _BudgetData(this.date, this.amount);

  final DateTime? date;
  final double amount;
}