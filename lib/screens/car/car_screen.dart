import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/color_utils.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
            SizedBox(height: 5),
            _CarRefuelTableHead(),
            _TableHeadSeparator(),
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

class _CarRefuelTableHead extends StatelessWidget {
  const _CarRefuelTableHead();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        _TableHeadline('Datum', 75, textAlign: TextAlign.start),
        _TableHeadline('km', 50),
        _TableHeadline('l', 25),
        _TableHeadline('€/l', 40),
        _TableHeadline('€', 50),
        _TableHeadline('l/100km', 70, textAlign: TextAlign.end),
      ],
    );
  }
}

class _TableHeadline extends StatelessWidget {
  final double width;
  final String title;
  final TextAlign textAlign;

  const _TableHeadline(
    this.title,
    this.width, {
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(title, textAlign: textAlign, style: Theme.of(context).textTheme.titleSmall),
    );
  }
}

class _TableHeadSeparator extends StatelessWidget {
  const _TableHeadSeparator();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            height: 1,
            width: 310, //240+70
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}

class _CarRefuelTable extends StatelessWidget {
  const _CarRefuelTable();

  @override
  Widget build(BuildContext context) {
    final carRefuelItems = Provider.of<Car>(context).carRefuelItems;
    return AnimationLimiter(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 1,
                width: 240,
                color: Colors.grey.shade200,
              ),
              Container(
                width: 70,
              ),
            ],
          ),
        ),
        itemBuilder: (ctx, index) => AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 250),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: _CarRefuelTableItem(
                  carRefuelItems[index], index < carRefuelItems.length - 1 ? carRefuelItems[index + 1] : null),
            ),
          ),
        ),
        itemCount: carRefuelItems.length,
      ),
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
      final double hue = min(90, max(-90, (lPer100km - 6) * 30));
      colorLiterPer100km = ColorUtils.hue(colorLiterPer100km, -hue);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 75,
          child: Text(_carRefuelItem.date),
        ),
        SizedBox(
          width: 50,
          child: Text(
            _carRefuelItem.km.toString(),
            textAlign: TextAlign.end,
          ),
        ),
        SizedBox(
          width: 25,
          child: Text(
            _carRefuelItem.liter.toString(),
            textAlign: TextAlign.end,
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(
            (_carRefuelItem.centPerliter / 100).toStringAsFixed(2),
            textAlign: TextAlign.end,
          ),
        ),
        SizedBox(
          width: 50,
          child: Text(
            priceInEuro,
            textAlign: TextAlign.end,
          ),
        ),
        SizedBox(
          width: 70,
          height: 30,
          // color: colorLiterPer100km,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (_prevCarRefuelItem != null)
                Positioned(
                  top: 19,
                  height: 22,
                  width: 5,
                  right: 0,
                  child: Container(
                    color: colorLiterPer100km,
                  ),
                ),
              if (_prevCarRefuelItem != null)
                Positioned(
                  top: 21,
                  height: 15,
                  width: 50,
                  right: 15,
                  child: Text(
                    litersPer100km,
                    textAlign: TextAlign.end,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
