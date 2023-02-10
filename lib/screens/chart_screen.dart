import 'package:flutter/material.dart';
import 'package:statistics/widgets/StatisticsAppBar.dart';

class ChartScreen extends StatelessWidget {
  static const String routeName = '/chart_screen';

  const ChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StatisticsAppBar(
        'Charts',
        context,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: const Center(child: Text('test')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Pressed');
        },
        tooltip: 'Neuer Eintrag',
        child: const Icon(Icons.add),
      ),
    );
  }
}
