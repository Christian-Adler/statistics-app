import 'package:flutter/material.dart';

import '../utils/globals.dart';

class ScrollFooter extends StatelessWidget {
  final double marginTop;
  final double marginBottom;

  const ScrollFooter({
    Key? key,
    this.marginTop = 0,
    this.marginBottom = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: marginTop,
        ),
        SizedBox(
          height: 40,
          width: 40,
          child: Image.asset(
            Globals.assetImgBackground,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: marginBottom,
        ),
      ],
    );
  }
}
