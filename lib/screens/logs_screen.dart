import 'package:flutter/material.dart';
import 'package:flutter_simple_logging/daily_files.dart';
import 'package:flutter_simple_logging/widgets/logs_view.dart';
import 'package:share_plus/share_plus.dart';

import '../generated/l10n.dart';
import '../models/navigation/screen_nav_info.dart';
import '../utils/dialog_utils.dart';
import '../utils/nav/navigator_transition_builder.dart';
import '../widgets/responsive/screen_layout_builder.dart';
import '../widgets/statistics_app_bar.dart';
import 'log_screen.dart';

class LogsScreen extends StatefulWidget {
  static final ScreenNavInfo screenNavInfo = ScreenNavInfo(
    (ctx) => S.of(ctx).screenTitleLogs,
    Icons.text_snippet_outlined,
    '/logs_screen',
    () => const LogsScreen(),
  );

  const LogsScreen({Key? key}) : super(key: key);

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  void _rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayoutBuilder(
      appBarBuilder: (ctx) => StatisticsAppBar(
        Text(LogsScreen.screenNavInfo.titleBuilder(ctx)),
        ctx,
        actions: [
          IconButton(
            onPressed: () async {
              try {
                final zipAllLogs = await DailyFiles.zipAllLogs();
                try {
                  await Share.shareXFiles([XFile(zipAllLogs)], text: 'App Logs');
                } catch (err) {
                  if (ctx.mounted) {
                    DialogUtils.showSimpleOkErrDialog('${S.of(ctx).commonsMsgErrorFailedToShareData}\n\n$err', ctx);
                  }
                }
              } catch (err) {
                DialogUtils.showSimpleOkErrDialog('${S.of(ctx).logsDialogMsgErrorFailedToZipLogs}\n\n$err', ctx);
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
                  content: Text(S.of(context).logsDialogMsgQueryDeleteAllLogs),
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
                        try {
                          await DailyFiles.deleteAllLogs();
                        } catch (err) {
                          DialogUtils.showSimpleOkErrDialog(
                              '${S.of(ctx).logsDialogMsgQueryDeleteAllLogs}\n\n$err', ctx);
                        }
                        _rebuild();
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
      ),
      bodyBuilder: (ctx) => LogsView(
        key: UniqueKey(),
        logSelectHandler: (String logFileName, void Function() rebuildLogsView) {
          Navigator.of(ctx).push(
            NavigatorTransitionBuilder.buildSlideHTransition(LogScreen(
              logFileName: logFileName,
              rebuildLogsView: rebuildLogsView,
            )),
          );
        },
      ),
    );
  }
}
