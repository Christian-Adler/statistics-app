import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SingleChildScrollViewWithScrollbar extends StatelessWidget {
  final Widget child;
  final Axis scrollDirection;
  final double Function()? getScrollPos;
  final void Function(double value)? setScrollPos;
  final void Function(ScrollDirection value)? setScrollDirection;

  SingleChildScrollViewWithScrollbar(
      {Key? key,
      required this.child,
      this.scrollDirection = Axis.vertical,
      this.getScrollPos,
      this.setScrollPos,
      this.setScrollDirection})
      : super(key: key);

  final ScrollController _scrollController = ScrollController();

  void scroll(double position) {
    _scrollController.jumpTo(position);
    // animateTo(20, duration: Duration(seconds: 0), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    final setScrollD = setScrollDirection;
    if (setScrollD != null) {
      _scrollController.addListener(() {
        setScrollD(_scrollController.position.userScrollDirection);
      });
    }
    final setScrollP = setScrollPos;
    if (setScrollP != null) {
      _scrollController.addListener(() {
        setScrollP(_scrollController.position.pixels);
      });
    }
    final getScrollP = getScrollPos;
    if (getScrollP != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => scroll(getScrollP()));
    }
    return Scrollbar(
      controller: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: scrollDirection,
        child: child,
      ),
    );
  }
}
