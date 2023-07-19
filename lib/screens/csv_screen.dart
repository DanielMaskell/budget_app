import 'dart:io';
import 'dart:convert';
import 'package:budget_app/bloc/payment_cubit.dart';
import 'package:budget_app/repository/payment_repository.dart';
import 'package:budget_app/repository/service/payment_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:budget_app/widgets/drawer.dart';
import 'package:budget_app/models/payment_hive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class CsvPage extends StatefulWidget {
  static const String routeName = '/csv';

  const CsvPage({Key? key}) : super(key: key);

  @override
  _CsvPageState createState() => _CsvPageState();
}

class _CsvPageState extends State<CsvPage> {
  final PaymentRepository paymentRepository = PaymentRepository(service: PaymentService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget App'),
      ),
      drawer: const SafeArea(child: AppDrawer()),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => fileSearch(),
              child: const Text('Add CSV'),
            ),
            const Spacer(),
            ElevatedButton(
              child: const Text('Clear Box'),
              onPressed: () async {
                var result = paymentRepository.clearPayments();
                print('Clearning box: $result');
                context.read<PaymentCubit>().getPayments();
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<List<dynamic>>> loadingCsvData(String path) async {
    final csvFile = File(path).openRead();
    return await csvFile.transform(utf8.decoder).transform(const CsvToListConverter()).toList();
  }

  void fileSearch() async {
    if (await Permission.storage.isPermanentlyDenied) {
      openAppSettings();
    }

    if (await requestPermission(Permission.storage)) {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path!);
        var data = await loadingCsvData(file.path);
        addCsvData(data);
      } else {
        // User canceled the picker
      }
    } else {
      print('---- no permission showing');
    }
  }

  void addCsvData(List<dynamic> data) async {
    int counter = 0;
    for (dynamic d in data) {
      counter++;
      if (d.length == 7 && counter > 7) {
        try {
          String newDate = d[0].toString().replaceAll('/', '-');
          print('d: ${d.toString()}');
          PaymentHive newPayment = PaymentHive(
            name: d[4],
            type: '',
            date: DateTime.parse(newDate),
            occurence: 'single',
            amount: d[6],
            referenceId: d[1],
          );

          var addingResult = await paymentRepository.addPayment(newPayment);
          context.read<PaymentCubit>().getPayments();
          setState(() {});
        } catch (e) {
          print('error adding payment: ${e.toString()}');
        }
      }
    }
  }

  Future<bool> requestPermission(Permission permission) async {
    print('request permission called');
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }
}
