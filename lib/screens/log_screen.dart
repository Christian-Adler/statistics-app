import 'package:flutter/material.dart';
import 'package:flutter_commons/widgets/responsive/screen_layout_builder.dart';
import 'package:flutter_simple_logging/daily_files.dart';
import 'package:flutter_simple_logging/widgets/log_view.dart';
import 'package:share_plus/share_plus.dart';

import '../generated/l10n.dart';
import '../models/navigation/screen_nav_info.dart';
import '../utils/dialog_utils.dart';
import '../widgets/statistics_app_bar.dart';

class LogScreen extends StatelessWidget {
  static final ScreenNavInfo screenNavInfo = ScreenNavInfo(
    (ctx) => S.of(ctx).screenTitleLog,
    Icons.text_snippet_outlined,
    '/log_screen',
    () => const LogScreen(),
  );

  const LogScreen({Key? key, this.logFileName, this.rebuildLogsView}) : super(key: key);

  final String? logFileName;
  final VoidCallback? rebuildLogsView;

  @override
  Widget build(BuildContext context) {
    String logFileN = (logFileName ?? '');
    return ScreenLayoutBuilder(
      appBarBuilder: (ctx) {
        return StatisticsAppBar(
          Text(LogScreen.screenNavInfo.titleBuilder(ctx) + logFileN.replaceAll('.txt', '')),
          ctx,
          actions: [
            IconButton(
              onPressed: () async {
                try {
                  await Share.shareXFiles([XFile(DailyFiles.getFullLogPath(logFileN))], text: 'App Log $logFileName');
                } catch (err) {
                  DialogUtils.showSimpleOkErrDialog('${S.of(ctx).commonsMsgErrorFailedToShareData}\n\n$err', ctx);
                }
              },
              icon: const Icon(Icons.share_outlined),
            ),
            IconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(S.of(context).commonsDialogTitleAreYouSure),
                    content: Text(S.of(context).logDialogMsgQueryDeleteLog),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: Text(S.of(context).commonsDialogBtnNo),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.of(ctx).pop(false);
                          Navigator.of(ctx).pop(false);
                          try {
                            await DailyFiles.deleteLog(logFileN);
                            // 1s warten, damit im Fall von heutigem Log das heutige File dann schon wieder erstellt wurde.
                            await Future.delayed(const Duration(seconds: 1), () {});
                          } catch (err) {
                            DialogUtils.showSimpleOkErrDialog(
                                '${S.of(ctx).logDialogMsgErrorDeleteLogFailed}\n\n$err', ctx);
                          }
                          final rebuildLogs = rebuildLogsView;
                          if (rebuildLogs != null) rebuildLogs();
                        },
                        child: Text(S.of(context).commonsDialogBtnYes),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        );
      },
      bodyBuilder: (ctx) => LogView(logFileN),
    );
  }
}
