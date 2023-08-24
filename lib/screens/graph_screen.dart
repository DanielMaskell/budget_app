import 'package:budget_app/bloc/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/widgets/drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../models/payment_hive.dart';
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
  }

  updateMonthData(int newMonth) {
    tempList = [];
    double total = 0;
    monthData = [];

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
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        List<double> days = [0];
        for (PaymentHive p in state.payments) {
          if (p.date.month == month && p.amount < 0) {
            if (days.isEmpty) {
              days.add(p.amount * -1);
            } else if (p.date.day == days.length) {
              days[p.date.day - 1] = days[p.date.day - 1] + p.amount * -1;
            } else {
              while (p.date.day > days.length) {
                days.add(days.last);
              }
            }
          }
        }

        List<Series<double, int>> graphData = [
          Series<double, int>(
            id: 'Payments',
            colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
            domainFn: (double p, i) => i!,
            measureFn: (double p, _) => p,
            data: days,
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
                        ),
                      );
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
