import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/color_utils.dart';
import 'package:flutter_commons/utils/media_query_utils.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../../../models/heart/blood_pressure_item.dart';
import '../../../providers/heart.dart';
import '../../../utils/hide_bottom_navigation_bar.dart';
import '../../scroll_footer.dart';

class HeartView extends StatelessWidget {
  const HeartView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Provider.of<Heart>(context, listen: false).fetchData(),
      child: _Heart(),
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
          return const LinearProgressIndicator();
        } else if (dataSnapshot.hasError) {
          // .. do error handling
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Error occurred:${dataSnapshot.error?.toString() ?? ''}'),
            ),
          );
        } else {
          final mediaQueryInfo = MediaQueryUtils(MediaQuery.of(context));
          double widthFactor = mediaQueryInfo.isTablet ? 1.6 : 1;
          return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const SizedBox(height: 5),
            _BloodPressureTableHead(widthFactor),
            _TableHeadSeparator(widthFactor),
            Expanded(
              child: _BloodPressureTable(widthFactor),
            )
          ]);
        }
      },
    );
  }
}

class _BloodPressureTableHead extends StatelessWidget {
  final double widthFactor;

  const _BloodPressureTableHead(this.widthFactor);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _TableHeadline('Datum', 110 * widthFactor, textAlign: TextAlign.start),
        _TableHeadline('Morgen', 70 * widthFactor),
        _TableHeadline('Mittag', 70 * widthFactor),
        _TableHeadline('Abend', 70 * widthFactor),
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
  final double widthFactor;

  const _TableHeadSeparator(this.widthFactor);

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
            width: 320 * widthFactor,
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}

class _BloodPressureTable extends StatefulWidget {
  final double widthFactor;

  const _BloodPressureTable(this.widthFactor);

  @override
  State<_BloodPressureTable> createState() => _BloodPressureTableState();
}

class _BloodPressureTableState extends State<_BloodPressureTable> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      HideBottomNavigationBar.setScrollDirection(_scrollController.position.userScrollDirection);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloodPressureItems = Provider.of<Heart>(context).bloodPressureItems;
    return AnimationLimiter(
      child: Scrollbar(
        controller: _scrollController,
        child: ListView.separated(
          controller: _scrollController,
          separatorBuilder: (context, index) => SizedBox(
            height: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 1,
                  width: 320 * widget.widthFactor,
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
                child: index == bloodPressureItems.length
                    ? const ScrollFooter(
                        marginTop: 20,
                        marginBottom: 10,
                        key: ValueKey('scroll-footer'),
                      )
                    : _BloodPressureTableItem(bloodPressureItems[index], widget.widthFactor),
              ),
            ),
          ),
          itemCount: bloodPressureItems.length + 1 /* +1 ScrollFooter */,
        ),
      ),
    );
  }
}

class _BloodPressureTableItem extends StatelessWidget {
  final BloodPressureItem _bloodPressureItem;
  final double widthFactor;

  _BloodPressureTableItem(this._bloodPressureItem, this.widthFactor) : super(key: ValueKey(_bloodPressureItem.date));

  @override
  Widget build(BuildContext context) {
    final Color? bgColor = _bloodPressureItem.date.startsWith('So')
        ? Colors.grey.shade300
        : (_bloodPressureItem.date.startsWith('Sa') ? Colors.grey.shade200 : null);

    return Center(
      child: Container(
        color: bgColor,
        width: 320 * widthFactor,
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 110 * widthFactor,
              child: Text(_bloodPressureItem.date),
            ),
            SizedBox(
              width: 70 * widthFactor,
              child: _BloodPressureValueRenderer(_bloodPressureItem.morning),
            ),
            SizedBox(
              width: 70 * widthFactor,
              child: _BloodPressureValueRenderer(_bloodPressureItem.midday),
            ),
            SizedBox(
              width: 70 * widthFactor,
              child: _BloodPressureValueRenderer(_bloodPressureItem.evening),
            ),
          ],
        ),
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
    var bloodPressureValues = _bloodPressureValues;
    if (bloodPressureValues == null || bloodPressureValues.isEmpty) return Container();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...bloodPressureValues.map((bpv) => Container(
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
