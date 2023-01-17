import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/statsscreen';

  @override
  _StatsScreen createState() => _StatsScreen();
}

class _StatsScreen extends State<StatsScreen> {

  @override 
  void initState() {
    super.initState();
  }

  @override 
  Widget build(BuildContext context) {
    return const Text('Test');
  }
}

