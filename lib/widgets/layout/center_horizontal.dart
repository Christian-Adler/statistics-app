import 'package:flutter/material.dart';

class CenterH extends StatelessWidget {
  final Widget child;

  const CenterH({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [child],
      ),
    );
  }
}
