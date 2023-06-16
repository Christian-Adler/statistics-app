import 'package:flutter/material.dart';
import 'package:flutter_commons/widgets/layout/single_child_scroll_view_with_scrollbar.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../providers/operating.dart';
import '../../../utils/dialog_utils.dart';
import '../../../utils/hide_bottom_navigation_bar.dart';
import '../../scroll_footer.dart';
import '../centered_error_text.dart';
import 'display/solar_power_chart.dart';
import 'display/solar_power_table.dart';

class SolarPowerView extends StatelessWidget {
  final bool _showYearly;

  const SolarPowerView({
    super.key,
    required bool showYearly,
  }) : _showYearly = showYearly;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        try {
          await Provider.of<Operating>(context, listen: false).fetchData();
        } catch (e) {
          await DialogUtils.showSimpleOkErrDialog(e, context);
        }
      },
      child: _SolarPower(_showYearly),
    );
  }
}

class _SolarPower extends StatefulWidget {
  final bool showYearly;

  const _SolarPower(this.showYearly);

  @override
  State<_SolarPower> createState() => _SolarPowerState();
}

class _SolarPowerState extends State<_SolarPower> {
  late Future _solarDataFuture;

  Future _obtainSolarDataFuture() {
    return Provider.of<Operating>(context, listen: false).fetchDataIfNotYetLoaded();
  }

  @override
  void initState() {
    // Falls build aufgrund anderer state-Aenderungen mehrmals ausgefuehrt wuerde.
    // Future nur einmal ausfuehren und speichern.
    _solarDataFuture = _obtainSolarDataFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _solarDataFuture,
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        } else if (dataSnapshot.hasError) {
          return CenteredErrorText(dataSnapshot.error!);
        } else {
          return SingleChildScrollViewWithScrollbar(
            scrollPositionHandler: HideBottomNavigationBar.setScrollPosition,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                      S.of(context).solarPowerTitle(widget.showYearly
                          ? S.of(context).solarPowerTitlePeriodYear
                          : S.of(context).solarPowerTitlePeriodMonth),
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(
                    height: 10,
                  ),
                  SolarPowerChart(widget.showYearly),
                  const SizedBox(
                    height: 20,
                  ),
                  SolarPowerTable(widget.showYearly),
                  const ScrollFooter(
                    marginTop: 20,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
