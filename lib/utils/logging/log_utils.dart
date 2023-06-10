import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_commons/utils/device_storage.dart';
import 'package:logger/logger.dart';
import 'package:statistics/utils/logging/daily_files.dart';

import '../device_storage_keys.dart';

class LogUtils {
  static Level _logLevel = Level.warning;

  static Level get logLevel {
    return _logLevel;
  }

  static set logLevel(Level logLevel) {
    _logLevel = logLevel;
    _store();
  }

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

  static void _store() async {
    try {
      final loggingData = {
        'logLevel': _logLevel.name,
      };
      await DeviceStorage.write(DeviceStorageKeys.keyLogging, jsonEncode(loggingData));
    } catch (err) {
      // await Dialogs.simpleOkDialog(err.toString(), context, title: 'Fehler');
    }
  }

  static Future<void> init() async {
    final dataStr = await DeviceStorage.read(DeviceStorageKeys.keyLogging);
    if (dataStr != null) {
      final data = jsonDecode(dataStr) as Map<String, dynamic>;
      if (data.containsKey('logLevel')) {
        final level = data['logLevel'] as String;
        _logLevel = getKnownLevels().firstWhere((element) => element.name == level, orElse: () => Level.warning);
      }
    }
  }
}

class _Printer extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    return [event.message.toString()];
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
  void output(OutputEvent event) {
    final fileLine = _StackUtils.determineFileLine();
    var error = event.origin.error;

    // FileOutput
    _Outputs.outFile(event, fileLine, error);
  }
}

class _LogOutputWithConsole extends LogOutput {
  @override
  void output(OutputEvent event) {
    final fileLine = _StackUtils.determineFileLine();
    var error = event.origin.error;

    _Outputs.outCons(event, fileLine, error);
    // FileOutput
    _Outputs.outFile(event, fileLine, error);
  }
}

class _Outputs {
  static final Map<Level, String> _levelMapping = {
    Level.verbose: 'VERB ',
    Level.debug: 'DEBUG',
    Level.info: 'INFO ',
    Level.warning: 'WARN ',
    Level.error: 'ERROR',
    Level.wtf: 'WTF  ',
  };

  static void outFile(OutputEvent event, String fileLine, dynamic error) {
    String logMsg = '';
    for (var line in event.lines) {
      if (logMsg.isNotEmpty) logMsg += '\n';
      logMsg += line;
    }

    logMsg = '${_normalizedLevel(event.level)} $fileLine $logMsg';
    if (error != null) {
      logMsg += '\n$error';
    }
    DailyFiles.writeToFile(logMsg);
  }

  static void outCons(OutputEvent event, String fileLine, dynamic error) {
    bool first = true;
    for (var line in event.lines) {
      if (kDebugMode) {
        if (first) {
          first = false;
          print('${_normalizedLevel(event.level)} $fileLine $line');
        } else {
          print(line);
        }
      }
    }
    if (error != null) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  static String _normalizedLevel(Level level) {
    return _levelMapping[level] ?? 'UNKNOWN';
  }
}

class _StackUtils {
  static String determineFileLine() {
    String fileLine = StackTrace.current
        .toString()
        .split('\n')
        .where(
          (line) =>
              !line.contains('package:logger') &&
              !line.contains('package:statistics/utils/logging/log_utils.dart') &&
              line.isNotEmpty,
        )
        .toList()
        .first;
    fileLine = fileLine.substring(fileLine.indexOf('('));
    // man koennte noch den standard-Package-Pfad kuerzen, aber dann kann man in der Console beim Debug nicht mehr klicken :(
    //.replaceFirst('package:statistics', '..');
    return fileLine;
  }
}
