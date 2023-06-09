import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:statistics/utils/logging/daily_files.dart';

class LogUtils {
  static Level logLevel = Level.info;

  static final logger = Logger(
    filter: _Filter(),
    level: Logger.level,
    printer: _Printer(),
    output: kDebugMode ? _LogOutputWithConsole() : _LogOutput(),
    // PrettyPrinter(
    //     methodCount: 1,
    //     // Number of method calls to be displayed
    //     errorMethodCount: 8,
    //     // Number of method calls if stacktrace is provided
    //     lineLength: 10,
    //     // Width of the output
    //     colors: false,
    //     // Colorful log messages
    //     printEmojis: false,
    //     // Print an emoji for each log message
    //     printTime: false // Should each log print contain a timestamp
    //     ),
  );

  static List<Level> getKnownLevels() {
    return [Level.debug, Level.info, Level.warning, Level.error];
  }
}

class _Printer extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    return [event.message];
  }
}

class _Filter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return (event.level.index >= LogUtils.logLevel.index);
  }
}

class _LogOutput extends LogOutput {
  @override
  void output(OutputEvent event) async {
    // FileOutput
    String logMsg = '';
    for (var line in event.lines) {
      if (logMsg.isNotEmpty) logMsg += '\n';
      logMsg += line;
    }
    logMsg = '${event.level.name} - $logMsg';
    DailyFiles.writeToFile(logMsg);
  }
}

class _LogOutputWithConsole extends LogOutput {
  @override
  void output(OutputEvent event) async {
    // FileOutput
    String logMsg = '';
    for (var line in event.lines) {
      if (kDebugMode) {
        print('${event.level.name.toUpperCase()} $line');
      }
      if (logMsg.isNotEmpty) logMsg += '\n';
      logMsg += line;
    }
    logMsg = '${event.level.name.toUpperCase()} $logMsg';
    DailyFiles.writeToFile(logMsg);
  }
}
