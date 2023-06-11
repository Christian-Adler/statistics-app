import 'package:flutter/cupertino.dart';

import 'error_code.dart';

class ErrorUtils {
  static String getErrorMessage(Object error, BuildContext context) {
    String errMsg = (error is ErrorCode) ? (error).i18n(context) : error.toString();
    return errMsg;
  }
}
