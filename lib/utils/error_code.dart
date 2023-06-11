import 'package:flutter/material.dart';

import '../generated/l10n.dart';

enum ErrorCode {
  authenticationFailed,
  failedToLoadDataFromServer,
  failedToSendDataToServer,
}

extension ErrorCodeExtension on ErrorCode {
  String i18n(BuildContext context) {
    switch (this) {
      case ErrorCode.failedToLoadDataFromServer:
        return S.of(context).commonsMsgErrorFailedToLoadData;
      case ErrorCode.failedToSendDataToServer:
        return S.of(context).commonsMsgErrorFailedToSendData;
      case ErrorCode.authenticationFailed:
        return S.of(context).authErrorMsgAuthenticationFailed;
      default:
        return 'Missing i18n error code!';
    }
  }
}
