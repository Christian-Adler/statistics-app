import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/color_utils.dart';
import 'package:flutter_commons/utils/hide_bottom_navigation_bar.dart';
import 'package:flutter_commons/utils/media_query_utils.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../models/car/car_refuel_item.dart';
import '../../../providers/car.dart';
import '../../../utils/dialog_utils.dart';
import '../../scroll_footer.dart';
import '../centered_error_text.dart';

class CarView extends StatelessWidget {
  const CarView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        try {
          await Provider.of<Car>(context, listen: false).fetchData();
        } catch (e) {
          await DialogUtils.showSimpleOkErrDialog(e, context);
        }
      },
      child: _Car(),
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
          return const LinearProgressIndicator();
        } else if (dataSnapshot.hasError) {
          return CenteredErrorText(dataSnapshot.error!);
        } else {
          final mediaQueryInfo = MediaQueryUtils(MediaQuery.of(context));
          double widthFactor = mediaQueryInfo.isTablet ? 1.6 : 1;
          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 5),
                _CarRefuelTableHead(widthFactor),
                _TableHeadSeparator(widthFactor),
                Expanded(
                  child: _CarRefuelTable(widthFactor),
                )
              ]);
        }
      },
    );
  }
}

class _CarRefuelTableHead extends StatelessWidget {
  final double widthFactor;

  const _CarRefuelTableHead(this.widthFactor);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _TableHeadline(S.of(context).carTableHeadDate, 85 * widthFactor,
            textAlign: TextAlign.start),
        _TableHeadline(S.of(context).carTableHeadKilometers, 50 * widthFactor),
        _TableHeadline(S.of(context).carTableHeadLiters, 25 * widthFactor),
        _TableHeadline(
            S.of(context).carTableHeadEuroPerLiter, 40 * widthFactor),
        _TableHeadline(S.of(context).carTableHeadEuro, 50 * widthFactor),
        _TableHeadline(
            S.of(context).carTableHeadLitersPer100Kilometers, 70 * widthFactor,
            textAlign: TextAlign.end),
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
      child: Text(title,
          textAlign: textAlign, style: Theme.of(context).textTheme.titleSmall),
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
            width: 320 * widthFactor, //250+70
            color: Theme.of(context).indicatorColor.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}

class _CarRefuelTable extends StatefulWidget {
  final double widthFactor;

  const _CarRefuelTable(this.widthFactor);

  @override
  State<_CarRefuelTable> createState() => _CarRefuelTableState();
}

class _CarRefuelTableState extends State<_CarRefuelTable> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      HideBottomNavigationBar.setScrollPosition(_scrollController.position);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final carRefuelItems = Provider.of<Car>(context).carRefuelItems;

    final separatorColor = Theme.of(context).indicatorColor.withOpacity(0.2);

    return AnimationLimiter(
      child: Scrollbar(
        controller: _scrollController,
        child: ListView.separated(
          controller: _scrollController,
          separatorBuilder: (ctx, index) => SizedBox(
            height: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 1,
                  width: 250 * widget.widthFactor,
                  color: separatorColor,
                ),
                Container(
                  width: 70 * widget.widthFactor,
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
                child: index == carRefuelItems.length
                    ? const ScrollFooter(
                        marginTop: 10,
                        marginBottom: 10,
                        key: ValueKey('scroll-footer'),
                      )
                    : _CarRefuelTableItem(
                        carRefuelItems[index],
                        widget.widthFactor,
                        index < carRefuelItems.length - 1
                            ? carRefuelItems[index + 1]
                            : null),
              ),
            ),
          ),
          itemCount: carRefuelItems.length + 1 /* +1 ScrollFooter */,
        ),
      ),
    );
  }
}

class _CarRefuelTableItem extends StatelessWidget {
  final CarRefuelItem _carRefuelItem;
  final double widthFactor;
  final CarRefuelItem? _prevCarRefuelItem;

  _CarRefuelTableItem(
      this._carRefuelItem, this.widthFactor, this._prevCarRefuelItem)
      : super(key: ValueKey(_carRefuelItem.km));

  @override
  Widget build(BuildContext context) {
    String priceInEuro =
        (_carRefuelItem.centPerliter * _carRefuelItem.liter / 100)
            .toStringAsFixed(2);
    String litersPer100km = '';
    Color colorLiterPer100km = const Color.fromRGBO(120, 255, 0, 1);
    var prevCarRefuelItem = _prevCarRefuelItem;
    if (prevCarRefuelItem != null) {
      final kmDistance = _carRefuelItem.km - prevCarRefuelItem.km;
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
          width: 85 * widthFactor,
          child: Text(_carRefuelItem.date),
        ),
        SizedBox(
          width: 50 * widthFactor,
          child: Text(
            _carRefuelItem.km.toString(),
            textAlign: TextAlign.end,
          ),
        ),
        SizedBox(
          width: 25 * widthFactor,
          child: Text(
            _carRefuelItem.liter.toString(),
            textAlign: TextAlign.end,
          ),
        ),
        SizedBox(
          width: 40 * widthFactor,
          child: Text(
            (_carRefuelItem.centPerliter / 100).toStringAsFixed(2),
            textAlign: TextAlign.end,
          ),
        ),
        SizedBox(
          width: 50 * widthFactor,
          child: Text(
            priceInEuro,
            textAlign: TextAlign.end,
          ),
        ),
        SizedBox(
          width: 70 * widthFactor,
          height: 30,
          // color: colorLiterPer100km,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (prevCarRefuelItem != null)
                Positioned(
                  top: 19,
                  height: 22,
                  width: 5,
                  right: 0,
                  child: Container(
                    color: colorLiterPer100km,
                  ),
                ),
              if (prevCarRefuelItem != null)
                Positioned(
                  top: 21,
                  height: 22,
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
