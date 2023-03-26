import 'package:flutter/material.dart';

import '../../utils/globals.dart';

class EagleLogo extends StatelessWidget {
  const EagleLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black26,
      radius: 30,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
            Globals.assetImgEagleLogo,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
