import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/media_query_utils.dart';

class DeviceDependentConstrainedBox extends StatelessWidget {
  final Widget child;

  const DeviceDependentConstrainedBox({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryInfo = MediaQueryUtils(MediaQuery.of(context));

    if (mediaQueryInfo.isTablet) {
      return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: child,
      );
    }

    return child;
  }
}
