import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:csv/csv.dart';

class CsvPage extends StatefulWidget {
  static const String routeName = '/csv';

  const CsvPage({Key? key}) : super(key: key);

  @override
  _CsvPageState createState() => _CsvPageState();
}

class _CsvPageState extends State<CsvPage> {
  // Directory appDocDir = await getApplicationDocumentsDirectory();
  //   String appDocPath = appDocDir.path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Budget App'),
        ),
        body: FutureBuilder(
            future: loadingCsvData('test_app/assets/test.csv'),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              print(snapshot.data.toString());
              return snapshot.hasData
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: snapshot.data!
                            .map((data) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: <Widget>[Text(data[0].toString()), Text(data[1].toString())],
                                  ),
                                ))
                            .toList(),
                      ))
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            }));
  }

  Future<List<List<dynamic>>> loadingCsvData(String path) async {
    // final csvFile = File(path).openRead();

    // return await csvFile
    //     .transform(utf8.decoder)
    //     .transform(
    //       const CsvToListConverter(),
    //     )
    //     .toList();
    final csvFile = await rootBundle.loadString('assets/test.csv');
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(csvFile);

    print("csvTable: $csvTable");

    return csvTable;
  }
}
