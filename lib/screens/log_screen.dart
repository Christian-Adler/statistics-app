import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/media_query_utils.dart';
import 'package:share_plus/share_plus.dart';

import '../generated/l10n.dart';
import '../models/navigation/screen_nav_info.dart';
import '../utils/dialog_utils.dart';
import '../utils/logging/daily_files.dart';
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

class _LogScreenBody extends StatefulWidget {
  const _LogScreenBody(this.logFileName);

  final String logFileName;

  @override
  State<_LogScreenBody> createState() => _LogScreenBodyState();
}

class _LogScreenBodyState extends State<_LogScreenBody> {
  void _rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
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
              return Text(S.of(ctx).logMsgErrorFileNotFound(widget.logFileName));
            }

            return _LogLines(
              logLines: logFileContent,
              refreshHandler: _rebuild,
            );
          },
          future: DailyFiles.readLogLines(widget.logFileName, context, !MediaQueryUtils.of(context).isTablet)),
    );
  }
}

class _LogLines extends StatelessWidget {
  const _LogLines({required this.logLines, required this.refreshHandler});

  final List<String> logLines;
  final VoidCallback refreshHandler;

  static const double linePad = 4;
  static const double outerPad = 8;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: RefreshIndicator(
        onRefresh: () async {
          refreshHandler();
        },
        child: ListView.builder(
            itemBuilder: (context, index) {
              var logLineText = logLines[index];
              var logLine = _LogLine(
                logLine: logLineText,
                key: ValueKey(logLineText.length > 28 ? logLineText.substring(0, 27) : logLineText),
              );

              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(left: outerPad, right: outerPad, top: outerPad, bottom: linePad),
                  child: logLine,
                );
              }
              if (index == logLines.length - 1) {
                return Padding(
                  padding: const EdgeInsets.only(left: outerPad, right: outerPad, top: linePad, bottom: outerPad),
                  child: logLine,
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: linePad, horizontal: outerPad),
                child: logLine,
              );
            },
            itemCount: logLines.length),
      ),
    );
  }
}

class _LogLine extends StatelessWidget {
  const _LogLine({
    super.key,
    required this.logLine,
  });

  final String logLine;

  @override
  Widget build(BuildContext context) {
    Color? col;
    if (logLine.contains('WARN')) {
      col = Colors.orange;
    } else if (logLine.contains('ERROR')) {
      col = Colors.red;
    }
    return Text(
      logLine,
      style: TextStyle(color: col),
    );
  }
}
