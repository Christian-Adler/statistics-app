import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/color_utils.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:statistics/models/heart/blood_pressure_item.dart';

import '../../providers/heart.dart';
import '../../widgets/add_value_floating_button.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/statistics_app_bar.dart';
import 'heart_add_value_screen.dart';

class HeartScreen extends StatelessWidget {
  static const String routeName = '/heart';
  static const String title = 'Blutdruck';
  static const IconData iconData = Icons.monitor_heart_outlined;

  const HeartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StatisticsAppBar(
        const Text(HeartScreen.title),
        context,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(HeartAddValueScreen.routeName),
            tooltip: 'Blutdruck Eintrag erstellen...',
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => Provider.of<Heart>(context, listen: false).fetchData(),
        child: _Heart(),
      ),
      floatingActionButton: const AddValueFloatingButton(),
    );
  }
}

class _Heart extends StatefulWidget {
  @override
  State<_Heart> createState() => _HeartState();
}

class _HeartState extends State<_Heart> {
  late Future _operatingDataFuture;

  Future _obtainHeartDataFuture() {
    return Provider.of<Heart>(context, listen: false).fetchDataIfNotYetLoaded();
  }

  @override
  void initState() {
    // Falls build aufgrund anderer state-Aenderungen mehrmals ausgefuehrt wuerde.
    // Future nur einmal ausfuehren und speichern.
    _operatingDataFuture = _obtainHeartDataFuture();
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
            _BloodPressureTableHead(),
            _TableHeadSeparator(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                child: _BloodPressureTable(),
              ),
            )
          ]);
        }
      },
    );
  }
}

class _BloodPressureTableHead extends StatelessWidget {
  const _BloodPressureTableHead();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        _TableHeadline('Datum', 110, textAlign: TextAlign.start),
        _TableHeadline('Morgen', 70),
        _TableHeadline('Mittag', 70),
        _TableHeadline('Abend', 70),
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
            width: 320,
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}

class _BloodPressureTable extends StatelessWidget {
  const _BloodPressureTable();

  @override
  Widget build(BuildContext context) {
    final bloodPressureItems = Provider.of<Heart>(context).bloodPressureItems;
    return AnimationLimiter(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 1,
                width: 320,
                color: Colors.grey.shade200,
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
              child: _BloodPressureTableItem(bloodPressureItems[index]),
            ),
          ),
        ),
        itemCount: bloodPressureItems.length,
      ),
    );
  }
}

class _BloodPressureTableItem extends StatelessWidget {
  final BloodPressureItem _bloodPressureItem;

  _BloodPressureTableItem(this._bloodPressureItem) : super(key: ValueKey(_bloodPressureItem.date));

  @override
  Widget build(BuildContext context) {
    final Color? bgColor = _bloodPressureItem.date.startsWith('So')
        ? Colors.grey.shade300
        : (_bloodPressureItem.date.startsWith('Sa') ? Colors.grey.shade200 : null);

    return Container(
      color: bgColor,
      width: 320,
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 110,
            child: Text(_bloodPressureItem.date),
          ),
          SizedBox(
            width: 70,
            child: _BloodPressureValueRenderer(_bloodPressureItem.morning),
          ),
          SizedBox(
            width: 70,
            child: _BloodPressureValueRenderer(_bloodPressureItem.midday),
          ),
          SizedBox(
            width: 70,
            child: _BloodPressureValueRenderer(_bloodPressureItem.evening),
          ),
        ],
      ),
    );
  }
}

class _BloodPressureValueRenderer extends StatelessWidget {
  final List<BloodPressureValue>? _bloodPressureValues;
  final bestPossibleValueColor = const Color.fromRGBO(0, 255, 0, 0.6);

  const _BloodPressureValueRenderer(this._bloodPressureValues);

  Color colorHigh(bloodPressureValue) {
    return ColorUtils.hue(bestPossibleValueColor, (120.0 - bloodPressureValue.high) * 4);
  }

  Color colorLow(bloodPressureValue) {
    return ColorUtils.hue(bestPossibleValueColor, (80.0 - bloodPressureValue.low) * 4.5);
  }

  @override
  Widget build(BuildContext context) {
    if (_bloodPressureValues == null || _bloodPressureValues!.isEmpty) return Container();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ..._bloodPressureValues!.map((bpv) => Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Theme.of(context).scaffoldBackgroundColor),
                gradient: LinearGradient(colors: [colorHigh(bpv), colorLow(bpv)]),
                // borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: Text(
                '${bpv.high} | ${bpv.low}',
                textAlign: TextAlign.center,
              ),
            )),
      ],
    );
  }
}
