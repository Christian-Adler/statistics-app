import 'package:flutter/material.dart';

class SingleChildScrollViewWithScrollbar extends StatelessWidget {
  final Widget child;
  final Axis scrollDirection;

  const SingleChildScrollViewWithScrollbar({Key? key, required this.child, this.scrollDirection = Axis.vertical})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scrollbar(
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: scrollDirection,
        child: child,
      ),
    );
  }
}
