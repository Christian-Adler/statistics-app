import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'fab_action_button_data.dart';
import 'utils/fab_action_button.dart';
import 'utils/tab_to_close_fab.dart';
import 'utils/tab_to_open_fab.dart';

@immutable
class FabRadialExpandable extends StatefulWidget {
  const FabRadialExpandable({
    super.key,
    required this.actions,
    this.iconData = Icons.circle_outlined,
    this.distance = 100,
    this.maxAngle = 90,
    this.startAngle = 0,
    this.initialOpen = false,
  });

  final bool initialOpen;
  final double distance;
  final double maxAngle;
  final double startAngle;
  final IconData iconData;
  final List<FabActionButtonData> actions;

  @override
  State<FabRadialExpandable> createState() => _FabRadialExpandableState();
}

class _FabRadialExpandableState extends State<FabRadialExpandable> with SingleTickerProviderStateMixin {
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
          ..._buildExpandingActionButtons(widget.maxAngle, widget.startAngle),
          TabToOpenFab(openFabIconData: widget.iconData, open: _open, toggle: _toggle),
        ],
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons(
    double maxAngle,
    double startAngle,
  ) {
    final children = <Widget>[];
    final count = widget.actions.length;
    final step = math.min(90.0, maxAngle) / (count - 1);
    for (var i = 0, angleInDegrees = math.max(0.0, startAngle); i < count; i++, angleInDegrees += step) {
      var action = widget.actions[i];
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
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
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
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
