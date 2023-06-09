import 'package:flutter/material.dart';
import 'package:statistics/utils/logging/daily_files.dart';
import 'package:statistics/widgets/layout/single_child_scroll_view_with_scrollbar.dart';

import '../generated/l10n.dart';
import '../models/navigation/screen_nav_info.dart';
import '../utils/nav/navigator_transition_builder.dart';
import '../widgets/responsive/screen_layout_builder.dart';
import '../widgets/statistics_app_bar.dart';
import 'log_screen.dart';

class LogsScreen extends StatelessWidget {
  static final ScreenNavInfo screenNavInfo = ScreenNavInfo(
    (ctx) => S.of(ctx).screenTitleLogs,
    Icons.text_snippet_outlined,
    '/logs_screen',
    () => const LogsScreen(),
  );

  const LogsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenLayoutBuilder(
      appBarBuilder: (ctx) => StatisticsAppBar(
        Text(LogsScreen.screenNavInfo.titleBuilder(ctx)),
        ctx,
      ),
      bodyBuilder: (ctx) => const _LogsScreenBody(),
    );
  }
}

class _LogsScreenBody extends StatelessWidget {
  const _LogsScreenBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('TODO LogLevel / delete all logs'),
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
                      children: [...logFiles.map((logFile) => Chip(logFile))],
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
  const Chip(this.logFileName, {super.key});

  final String logFileName;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      // avatar: Icon(Icons.favorite),
      label: Text(logFileName.replaceAll('.txt', '')),
      onPressed: () => Navigator.of(context).push(
        NavigatorTransitionBuilder.buildSlideHTransition(LogScreen(
          logFileName: logFileName,
        )),
      ),
    );
  }
}
