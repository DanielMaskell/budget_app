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
  List<BudgetData> tempList = [];
  List<BudgetData> monthData = [];
  final PaymentRepository paymentRepository = PaymentRepository();
  late final Map<dynamic, PaymentHive> payments = paymentRepository.getBox();
  late Box<PaymentHive> paymentBox;
  int month = 1;
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

  @override
  void initState() {
    super.initState();
    paymentBox = Hive.box<PaymentHive>('paymentBoxTest');
    updateMonthData(month);
  }

  updateMonthData(int newMonth) {
    tempList = [];
    double total = 0;
    monthData = [];

    paymentBox.toMap().forEach((key, value) {
      DateTime tempDate = DateTime(value.date.year, value.date.month, value.date.day);
      BudgetData tempItem = BudgetData(DateTime.tryParse(DateFormat('yyyy-MM-dd').format(tempDate))!, value.amount);
      tempList.add(tempItem);
    });
    tempList.sort(((a, b) => b.compareTo(a)));

    for (BudgetData item in tempList) {
      if (item.date.month == month) {
        total = total + item.amount;
        DateTime tempDate = DateTime(item.date.year, item.date.month, item.date.day);
        BudgetData tempItem = BudgetData(DateTime.tryParse(DateFormat('yyyy-MM-dd').format(tempDate))!, total);
        monthData.add(tempItem);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
      ),
      drawer: const SafeArea(child: AppDrawer()),
      body: Column(children: [
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
        Expanded(
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(
              labelPlacement: LabelPlacement.onTicks,
            ),
            title: ChartTitle(text: 'Test Chart'),
            legend: Legend(isVisible: false),
            enableAxisAnimation: true,
            series: <ChartSeries<BudgetData, String>>[
              LineSeries<BudgetData, String>(
                dataSource: monthData,
                xValueMapper: (BudgetData sales, _) => sales.date.day.toString(),
                yValueMapper: (BudgetData sales, _) => sales.amount,
                name: 'Expenses',
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              )
            ],
          ),
        ),
      ]),
    );
  }
}

class BudgetData implements Comparable<BudgetData> {
  BudgetData(this.date, this.amount);

  final DateTime date;
  final double amount;

  @override
  int compareTo(BudgetData other) {
    if (date.isBefore(other.date)) {
      return 1;
    } else if (date.isAfter(other.date)) {
      return -1;
    } else {
      return 0;
    }
  }
}
