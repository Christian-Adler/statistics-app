import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/color_utils.dart';
import 'package:provider/provider.dart';
import 'package:statistics/models/car/car_refuel_item.dart';

import '../../providers/car.dart';
import '../../widgets/add_value_floating_button.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/statistics_app_bar.dart';
import 'car_add_value_screen.dart';

class CarScreen extends StatelessWidget {
  static const String routeName = '/car';

  const CarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StatisticsAppBar(
        const Text('Tanken'),
        context,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(CarAddValueScreen.routeName),
            tooltip: 'Tanken Eintrag erstellen...',
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => Provider.of<Car>(context, listen: false).fetchData(),
        child: _Car(),
      ),
      floatingActionButton: const AddValueFloatingButton(),
    );
  }
}

class _Car extends StatefulWidget {
  @override
  State<_Car> createState() => _CarState();
}

class _CarState extends State<_Car> {
  late Future _operatingDataFuture;

  Future _obtainCarDataFuture() {
    return Provider.of<Car>(context, listen: false).fetchDataIfNotYetLoaded();
  }

  @override
  void initState() {
    // Falls build aufgrund anderer state-Aenderungen mehrmals ausgefuehrt wuerde.
    // Future nur einmal ausfuehren und speichern.
    _operatingDataFuture = _obtainCarDataFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _operatingDataFuture,
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: CircularProgressIndicator(),
            ),
          );
        } else if (dataSnapshot.hasError) {
          // .. do error handling
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Error occurred:${dataSnapshot.error?.toString() ?? ''}'),
            ),
          );
        } else {
          return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: const [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                child: _CarRefuelTable(),
              ),
            )
          ]);
        }
      },
    );
  }
}

class _CarRefuelTable extends StatelessWidget {
  const _CarRefuelTable();

  @override
  Widget build(BuildContext context) {
    final carRefuelItems = Provider.of<Car>(context).carRefuelItems;
    return ListView.builder(
      itemBuilder: (ctx, index) => _CarRefuelTableItem(
          carRefuelItems[index], index < carRefuelItems.length - 1 ? carRefuelItems[index + 1] : null),
      itemCount: carRefuelItems.length,
    );
  }
}

class _CarRefuelTableItem extends StatelessWidget {
  final CarRefuelItem _carRefuelItem;
  final CarRefuelItem? _prevCarRefuelItem;

  _CarRefuelTableItem(this._carRefuelItem, this._prevCarRefuelItem) : super(key: ValueKey(_carRefuelItem.km));

  @override
  Widget build(BuildContext context) {
    String priceInEuro = (_carRefuelItem.centPerliter * _carRefuelItem.liter / 100).toStringAsFixed(2);
    String litersPer100km = '';
    Color colorLiterPer100km = const Color.fromRGBO(120, 255, 0, 1);
    if (_prevCarRefuelItem != null) {
      final kmDistance = _carRefuelItem.km - _prevCarRefuelItem!.km;
      // Annahme: immer voll getankt. Daher haben wir seit dem letzten Tanken genau die Tankmenge verbraucht.
      final lPer100km = (_carRefuelItem.liter / kmDistance * 100);
      litersPer100km = lPer100km < 4 ? '---' : lPer100km.toStringAsFixed(2);
      final hue = (lPer100km - 6) * 30;
      colorLiterPer100km = ColorUtils.hue(colorLiterPer100km, -hue);
    }

    return Row(
      children: [
        Container(
          width: 75,
          color: Colors.redAccent,
          child: Text(_carRefuelItem.date),
        ),
        Container(
          width: 50,
          color: Colors.orange,
          child: Text(
            _carRefuelItem.km.toString(),
            textAlign: TextAlign.end,
          ),
        ),
        Container(
          width: 25,
          color: Colors.blueAccent,
          child: Text(
            _carRefuelItem.liter.toString(),
            textAlign: TextAlign.end,
          ),
        ),
        Container(
          width: 40,
          color: Colors.deepPurple,
          child: Text(
            (_carRefuelItem.centPerliter / 100).toString(),
            textAlign: TextAlign.end,
          ),
        ),
        Container(
          width: 50,
          color: Colors.cyanAccent,
          child: Text(
            priceInEuro,
            textAlign: TextAlign.end,
          ),
        ),
        Container(
          width: 50,
          color: colorLiterPer100km,
          child: Text(
            litersPer100km,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
