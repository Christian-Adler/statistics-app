import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SingleChildScrollViewWithScrollbar extends StatefulWidget {
  final Widget child;
  final Axis scrollDirection;
  final double Function()? getScrollPos;
  final void Function(double value)? setScrollPos;
  final void Function(ScrollDirection value)? setScrollDirection;

  const SingleChildScrollViewWithScrollbar(
      {Key? key,
      required this.child,
      this.scrollDirection = Axis.vertical,
      this.getScrollPos,
      this.setScrollPos,
      this.setScrollDirection})
      : super(key: key);

  @override
  State<SingleChildScrollViewWithScrollbar> createState() => _SingleChildScrollViewWithScrollbarState();
}

class _SingleChildScrollViewWithScrollbarState extends State<SingleChildScrollViewWithScrollbar> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scroll(double position) {
    _scrollController.jumpTo(position);
    // animateTo(20, duration: Duration(seconds: 0), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    final setScrollD = widget.setScrollDirection;
    if (setScrollD != null) {
      _scrollController.addListener(() {
        setScrollD(_scrollController.position.userScrollDirection);
      });
    }
    final setScrollP = widget.setScrollPos;
    if (setScrollP != null) {
      _scrollController.addListener(() {
        setScrollP(_scrollController.position.pixels);
      });
    }
    final getScrollP = widget.getScrollPos;
    if (getScrollP != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => scroll(getScrollP()));
    }
    return Scrollbar(
      controller: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: widget.scrollDirection,
        child: widget.child,
      ),
    );
  }
}
