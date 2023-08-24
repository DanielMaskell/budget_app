import 'package:budget_app/bloc/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/widgets/drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:budget_app/repository/payment_repository.dart';
import '../models/payment_hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart';

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
  // final PaymentRepository paymentRepository = PaymentRepository();
  // late final Map<dynamic, PaymentHive> payments = paymentRepository.getBox();
  // late Box<PaymentHive> paymentBox;
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
    'December': 12,
  };

  @override
  void initState() {
    super.initState();
    // paymentBox = Hive.box<PaymentHive>('paymentBoxTest');
    // updateMonthData(month);
  }

  updateMonthData(int newMonth) {
    tempList = [];
    double total = 0;
    monthData = [];

    // paymentBox.toMap().forEach((key, value) {
    //   DateTime tempDate =
    //       DateTime(value.date.year, value.date.month, value.date.day);
    //   BudgetData tempItem = BudgetData(
    //       DateTime.tryParse(DateFormat('yyyy-MM-dd').format(tempDate))!,
    //       value.amount);
    //   tempList.add(tempItem);
    // });
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

  // static List<Series<PaymentHive, int>> _createSampleData() {
  //   final data = [
  //     new PaymentHive(),
  //     new LinearSales(1, 25),
  //     new LinearSales(2, 100),
  //     new LinearSales(3, 75),
  //   ];

  // static List<Series<LinearSales, int>> _createSampleData() {
  //   final data = [
  //     new LinearSales(0, 5),
  //     new LinearSales(1, 25),
  //     new LinearSales(2, 100),
  //     new LinearSales(3, 75),
  //   ];

  //   return [
  //     new Series<LinearSales, int>(
  //       id: 'Sales',
  //       colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
  //       domainFn: (LinearSales sales, _) => sales.year,
  //       measureFn: (LinearSales sales, _) => sales.sales,
  //       data: data,
  //     )
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        List<PaymentHive> monthsPayments = [];
        // List<double> days = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31];
        List<double> days = [0];
        // days.length = 31;
        for (PaymentHive p in state.payments) {
          print('days ${days.length}: ${days.toString()}');
          print('new for entry');
          if (p.date.month == month && p.amount < 0) {
            // monthsPayments.add(p);

            // days[p.date.day] == null ? days[p.date.day] = p.amount : days[p.date.day] = days[p.date.day]! + p.amount;
            if (days.isEmpty) {
              print('--- days is empty');
              days.add(p.amount * -1);
            } else if (p.date.day == days.length) {
              print('--- days payment date is days length + 1');
              days[p.date.day - 1] = days[p.date.day - 1] + p.amount * -1;
            } else {
              while (p.date.day > days.length) {
                print('--- days while loop');
                days.add(days.last);
              }
            }
          }
        }
        print('days: ${days.toString()}');

        List<Series<double, int>> graphData = [
          Series<double, int>(
            id: 'Payments',
            colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
            domainFn: (double p, i) => i!,
            measureFn: (double p, _) => p,
            data: days /*monthsPayments*/,
          ),
        ];

        return Scaffold(
          appBar: AppBar(
            title: const Text('Payments'),
          ),
          drawer: const SafeArea(child: AppDrawer()),
          body: Column(
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
              Expanded(
                child: LineChart(graphData),
                // child: SfCartesianChart(
                //   primaryXAxis: CategoryAxis(
                //     labelPlacement: LabelPlacement.onTicks,
                //   ),
                //   title: ChartTitle(text: 'Test Chart'),
                //   legend: Legend(isVisible: false),
                //   enableAxisAnimation: true,
                //   series: <ChartSeries<BudgetData, String>>[
                //     LineSeries<BudgetData, String>(
                //       dataSource: monthData,
                //       xValueMapper: (BudgetData sales, _) => sales.date.day.toString(),
                //       yValueMapper: (BudgetData sales, _) => sales.amount,
                //       name: 'Expenses',
                //       dataLabelSettings: const DataLabelSettings(isVisible: true),
                //     )
                //   ],
                // ),
              ),
            ],
          ),
        );
      },
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

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

// List<Series<int, int>> testData = [
  //   Series(
  //     id: 'Test',
  //     data: [1, 2],
  //     colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
  //     domainFn: (i, _) => 1,
  //     measureFn: (k, _) => 2,
  //   ),
  //   Series(
  //     id: 'Test',
  //     data: [2, 12],
  //     colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
  //     domainFn: (i, _) => 2,
  //     measureFn: (k, _) => 12,
  //   ),
  //   Series(
  //     id: 'Test',
  //     data: [3, 22],
  //     colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
  //     domainFn: (i, _) => 3,
  //     measureFn: (k, _) => 22,
  //   ),
  // ];