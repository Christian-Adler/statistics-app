import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SingleChildScrollViewWithScrollbar extends StatefulWidget {
  final Widget child;
  final Axis scrollDirection;
  final double Function()? getScrollPos;
  final void Function(double value)? scrollPosCallback;
  final void Function(ScrollDirection value)? scrollDirectionCallback;

  const SingleChildScrollViewWithScrollbar(
      {Key? key,
      required this.child,
      this.scrollDirection = Axis.vertical,
      this.getScrollPos,
      this.scrollPosCallback,
      this.scrollDirectionCallback})
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
    final scrollDirectionCb = widget.scrollDirectionCallback;
    if (scrollDirectionCb != null) {
      _scrollController.addListener(() {
        scrollDirectionCb(_scrollController.position.userScrollDirection);
      });
    }
    final scrollPosCb = widget.scrollPosCallback;
    if (scrollPosCb != null) {
      _scrollController.addListener(() {
        scrollPosCb(_scrollController.position.pixels);
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
