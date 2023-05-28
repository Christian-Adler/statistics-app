import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'fab_action_button_data.dart';
import 'utils/fab_action_button.dart';
import 'utils/tab_to_close_fab.dart';
import 'utils/tab_to_open_fab.dart';

@immutable
class FabVerticalExpandable extends StatefulWidget {
  const FabVerticalExpandable({
    super.key,
    required this.actions,
    this.iconData = Icons.more_vert,
    this.distance = 100,
    this.initialOpen = false,
  });

  final bool initialOpen;
  final double distance;
  final IconData iconData;
  final List<FabActionButtonData> actions;

  @override
  State<FabVerticalExpandable> createState() => _FabVerticalExpandableState();
}

class _FabVerticalExpandableState extends State<FabVerticalExpandable> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _close() {
    setState(() {
      _open = false;
      _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          TabToCloseFab(toggle: _toggle),
          ..._buildExpandingActionButtons(widget.distance),
          TabToOpenFab(openFabIconData: widget.iconData, open: _open, toggle: _toggle),
        ],
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons(
    double distance,
  ) {
    final children = <Widget>[];
    final count = widget.actions.length;
    final step = math.max(56.0, distance);
    for (var i = 0; i < count; i++) {
      var action = widget.actions[i];
      children.add(
        _ExpandingActionButton(
          maxDistance: step * (i + 1),
          progress: _expandAnimation,
          child: FabActionButton(
            onPressed: () {
              if (action.autoClose) _close();
              action.onPressed();
            },
            icon: Icon(action.iconData),
          ),
        ),
      );
    }
    return children;
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          90 * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}
