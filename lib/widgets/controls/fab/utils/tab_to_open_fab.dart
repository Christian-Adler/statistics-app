import 'package:flutter/material.dart';

class TabToOpenFab extends StatelessWidget {
  const TabToOpenFab({Key? key, required this.openFabIconData, required this.open, required this.toggle})
      : super(key: key);

  final IconData openFabIconData;
  final bool open;
  final VoidCallback toggle;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          open ? 0.7 : 1.0,
          open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: toggle,
            heroTag: null,
            child: Icon(openFabIconData),
          ),
        ),
      ),
    );
  }
}
