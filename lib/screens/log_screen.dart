import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../generated/l10n.dart';
import '../models/navigation/screen_nav_info.dart';
import '../utils/dialog_utils.dart';
import '../utils/logging/daily_files.dart';
import '../widgets/layout/single_child_scroll_view_with_scrollbar.dart';
import '../widgets/responsive/screen_layout_builder.dart';
import '../widgets/statistics_app_bar.dart';

class LogScreen extends StatelessWidget {
  static final ScreenNavInfo screenNavInfo = ScreenNavInfo(
    (ctx) => S.of(ctx).screenTitleLog,
    Icons.text_snippet_outlined,
    '/log_screen',
    () => const LogScreen(),
  );

  const LogScreen({Key? key, this.logFileName, this.rebuildLogsScreen}) : super(key: key);

  final String? logFileName;
  final VoidCallback? rebuildLogsScreen;

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
              onPressed: () {
                Share.shareXFiles([XFile(DailyFiles.getFullLogPath(logFileN))], text: 'App Log $logFileName');
              },
              icon: const Icon(Icons.share_outlined),
            ),
            IconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(S.of(context).commonsDialogTitleAreYouSure),
                    content: Text(S.of(context).logDialogMsgDeleteLog),
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
                          } catch (err) {
                            DialogUtils.showSimpleOkErrDialog('${S.of(ctx).logDialogMsgDeleteLogFailed}\n\n$err', ctx);
                          }
                          final rebuildLogs = rebuildLogsScreen;
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
      bodyBuilder: (ctx) => _LogScreenBody(logFileN),
    );
  }
}

class _LogScreenBody extends StatelessWidget {
  const _LogScreenBody(this.logFileName);

  final String logFileName;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollViewWithScrollbar(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LinearProgressIndicator();
              } else if (snapshot.hasError) {
                // .. do error handling
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('${S.of(ctx).commonsMsgErrorFailedToLoadData} ${snapshot.error?.toString() ?? ''}'),
                  ),
                );
              }
              final logFileContent = snapshot.data;
              if (logFileContent == null) {
                return Text(S.of(ctx).logMsgFileNotFound(logFileName));
              }

              return Text(logFileContent,
                  style: const TextStyle(
                    fontFeatures: [FontFeature.tabularFigures()],
                  ));
            },
            future: DailyFiles.readLog(logFileName, context)),
      ),
    );
  }
}
