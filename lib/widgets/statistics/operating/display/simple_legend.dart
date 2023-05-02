import 'package:flutter/material.dart';

import '../../../../models/chart/legend_item.dart';
import '../../../../utils/charts.dart';

class SimpleLegend extends StatelessWidget {
  final List<LegendItem> items;

  const SimpleLegend({Key? key, required this.items}) : super(key: key);

  List<Widget> _buildSimpleLegendItems() {
    List<Widget> result = [];
    for (var item in items) {
      if (result.isNotEmpty) {
        result.add(const SizedBox(
          width: 20,
        ));
      }
      result.add(SimpleLegendItem(legendItem: item));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 10),
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _buildSimpleLegendItems(),
          ),
        ),
      ),
    );
  }
}

class SimpleLegendItem extends StatelessWidget {
  final LegendItem legendItem;

  const SimpleLegendItem({
    super.key,
    required this.legendItem,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 20,
          margin: const EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
              gradient: Charts.createTopToBottomGradient(legendItem.gradientColors),
              borderRadius: BorderRadius.circular(5)),
        ),
        Text(legendItem.text),
      ],
    );
  }
}
