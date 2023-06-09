import 'package:flutter/cupertino.dart';
import 'package:flutter_commons/utils/dialogs.dart';

import '../generated/l10n.dart';

class DialogUtils {
  static Future<void> showSimpleOkErrDialog(String text, BuildContext context) async {
    final i18n = S.of(context);
    await Dialogs.simpleOkDialog(text, context,
        title: i18n.commonsDialogTitleErrorOccurred, buttonText: i18n.commonsDialogBtnOkay);
  }
}
