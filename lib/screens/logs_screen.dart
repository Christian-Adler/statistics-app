import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:share_plus/share_plus.dart';

import '../generated/l10n.dart';
import '../models/navigation/screen_nav_info.dart';
import '../utils/dialog_utils.dart';
import '../utils/logging/daily_files.dart';
import '../utils/logging/log_utils.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
                    child: Text('${S.of(context).commonsMsgErrorFailedToLoadData} ${snapshot.error?.toString() ?? ''}'),
                  ),
                );
              }
              final logFiles = snapshot.data;
              if (logFiles == null) {
                return Center(
                  child: Text(S.of(context).logsMsgNoLogFilesFound),
                );
              }
              return SingleChildScrollViewWithScrollbar(
                onRefresh: () async {
                  _rebuild();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                    child: Wrap(
                      spacing: 16,
                      children: [...logFiles.map((logFile) => Chip(logFile, _rebuild))],
                    ),
                  ),
                ),
              );
            },
            future: DailyFiles.listLogFileNames(),
          ),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(S.of(context).logsLabelChooseLogLevel),
            ),
            const _LogLevelSelector(),
          ],
        ),
      ],
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
      avatar: Icon(Icons.short_text_outlined, color: Theme.of(context).colorScheme.primary),
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

class _LogLevelSelector extends StatefulWidget {
  const _LogLevelSelector();

  @override
  State<_LogLevelSelector> createState() => _LogLevelSelectorState();
}

class _LogLevelSelectorState extends State<_LogLevelSelector> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return DropdownButton<Level>(
        icon: Icon(
          Icons.arrow_drop_down_outlined,
          color: themeData.colorScheme.primary,
        ),
        underline: Container(
          height: 1,
          color: themeData.colorScheme.primary,
        ),
        value: LogUtils.logLevel,
        items: LogUtils.getKnownLevels().map<DropdownMenuItem<Level>>((logLevel) {
          BoxDecoration? boxDeco;
          if (logLevel == LogUtils.logLevel) {
            boxDeco = BoxDecoration(border: Border(bottom: BorderSide(color: themeData.colorScheme.primary)));
          }
          return DropdownMenuItem(
              value: logLevel,
              child: Container(
                  decoration: boxDeco,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(logLevel.name.toUpperCase()),
                  )));
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            LogUtils.logLevel = value;
            setState(() {});
          }
        });
  }
}
