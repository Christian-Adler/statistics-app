import 'package:flutter/material.dart';

class OrientationLayoutBuilder extends StatelessWidget {
  final Widget Function(BuildContext context)? landscape;
  final Widget Function(BuildContext context)? portrait;

  const OrientationLayoutBuilder({Key? key, this.landscape, this.portrait}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // only one builder set?
    if (landscape == null && portrait != null) return portrait!(context);
    if (landscape != null && portrait == null) return landscape!(context);

    final orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape && landscape != null) {
      return landscape!(context);
    }
    if (orientation == Orientation.portrait && portrait != null) {
      return portrait!(context);
    }
    return const Placeholder();
  }
}
