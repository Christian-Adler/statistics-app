import 'package:flutter/cupertino.dart';
import 'package:flutter_commons/utils/dialogs.dart';

import '../generated/l10n.dart';
import 'error_utils.dart';

class DialogUtils {
  static Future<void> showSimpleOkErrDialog(Object err, BuildContext context) async {
    final i18n = S.of(context);
    final errMsg = ErrorUtils.getErrorMessage(err, context);
    await Dialogs.simpleOkDialog(errMsg, context,
        title: i18n.commonsDialogTitleErrorOccurred, buttonText: i18n.commonsDialogBtnOkay);
  }
}
