import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../generated/l10n.dart';
import '../models/navigation/screen_nav_info.dart';
import '../utils/dialog_utils.dart';
import '../utils/logging/daily_files.dart';
import '../utils/nav/navigator_transition_builder.dart';
import '../widgets/layout/single_child_scroll_view_with_scrollbar.dart';
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
                await Share.shareXFiles([XFile(zipAllLogs)], text: 'App Logs');
              } catch (err) {
                DialogUtils.showSimpleOkErrDialog("Failed to zip and share all logs! $err", ctx); // TODO i18n
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
                  content: Text(S.of(context).settingsDeviceStorageDialogMsgRemoveAllDataAndLogout), // TODO message
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
                          DialogUtils.showSimpleOkErrDialog("Failed to clear all logs! $err", ctx); // TODO i18n
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
      bodyBuilder: (ctx) => _LogsScreenBody(key: UniqueKey()),
    );
  }
}

class _LogsScreenBody extends StatefulWidget {
  const _LogsScreenBody({Key? key});

  @override
  State<_LogsScreenBody> createState() => _LogsScreenBodyState();
}

class _LogsScreenBodyState extends State<_LogsScreenBody> {
  void _rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('TODO LogLevel '), // TODO LogLevel
          const Divider(),
          Expanded(
            child: FutureBuilder(
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LinearProgressIndicator();
                } else if (snapshot.hasError) {
                  // .. do error handling
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                          '${S.of(context).commonsMsgErrorFailedToLoadData} ${snapshot.error?.toString() ?? ''}'), // TODO ErrorLog
                    ),
                  );
                }
                final logFiles = snapshot.data;
                if (logFiles == null) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('No log files'), // TODO MessageI18n
                    ),
                  );
                }
                return SingleChildScrollViewWithScrollbar(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Wrap(
                      spacing: 16,
                      children: [...logFiles.map((logFile) => Chip(logFile, _rebuild))],
                    ),
                  ),
                );
              },
              future: DailyFiles.listLogFileNames(),
            ),
          ),
        ],
      ),
    );
  }
}

class Chip extends StatelessWidget {
  const Chip(this.logFileName, this.rebuildLogsScreen, {super.key});

  final String logFileName;
  final VoidCallback? rebuildLogsScreen;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      // avatar: Icon(Icons.favorite),
      label: Text(logFileName.replaceAll('.txt', '')),
      onPressed: () => Navigator.of(context).push(
        NavigatorTransitionBuilder.buildSlideHTransition(LogScreen(
          logFileName: logFileName,
          rebuildLogsScreen: rebuildLogsScreen,
        )),
      ),
    );
  }
}
