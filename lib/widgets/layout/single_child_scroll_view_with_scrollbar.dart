import 'package:flutter/material.dart';

class SingleChildScrollViewWithScrollbar extends StatefulWidget {
  final Widget child;
  final Axis scrollDirection;
  final double Function()? getScrollPos;
  final void Function(ScrollPosition value)? scrollPositionCallback;
  final Future<void> Function()? onRefresh;

  const SingleChildScrollViewWithScrollbar(
      {Key? key,
      required this.child,
      this.scrollDirection = Axis.vertical,
      this.getScrollPos,
      this.scrollPositionCallback,
      this.onRefresh})
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
    final scrollPositionCb = widget.scrollPositionCallback;
    if (scrollPositionCb != null) {
      _scrollController.addListener(() {
        scrollPositionCb(_scrollController.position);
      });
    }
    final getScrollP = widget.getScrollPos;
    if (getScrollP != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => scroll(getScrollP()));
    }

    final refreshHandler = widget.onRefresh;
    ScrollPhysics? scrollPhysics = (refreshHandler != null) ? const AlwaysScrollableScrollPhysics() : null;

    final scrollbar = Scrollbar(
      controller: _scrollController,
      child: SingleChildScrollView(
        physics: scrollPhysics,
        controller: _scrollController,
        scrollDirection: widget.scrollDirection,
        child: widget.child,
      ),
    );

    if (refreshHandler == null) {
      return scrollbar;
    }

    return RefreshIndicator(onRefresh: refreshHandler, child: scrollbar);
  }
}
