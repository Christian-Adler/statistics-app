import 'package:flutter/material.dart';

import '../../utils/error_utils.dart';

class CenteredErrorText extends StatelessWidget {
  const CenteredErrorText(this.error, {super.key});

  final Object error;

  @override
  Widget build(BuildContext context) {
    String errMsg = ErrorUtils.getErrorMessage(error, context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(errMsg),
      ),
    );
  }
}
