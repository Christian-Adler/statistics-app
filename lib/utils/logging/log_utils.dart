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
  void output(OutputEvent event) {
    // FileOutput
    _Outputs.outFile(event);
  }
}

class _LogOutputWithConsole extends LogOutput {
  @override
  void output(OutputEvent event) {
    _Outputs.outCons(event);
    // FileOutput
    _Outputs.outFile(event);
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

  static void outFile(OutputEvent event) {
    String logMsg = '';
    for (var line in event.lines) {
      if (logMsg.isNotEmpty) logMsg += '\n';
      logMsg += line;
    }
    logMsg = '${_normalizedLevel(event.level)} | $logMsg';
    DailyFiles.writeToFile(logMsg);
  }

  static void outCons(OutputEvent event) {
    for (var line in event.lines) {
      if (kDebugMode) {
        print('${_normalizedLevel(event.level)} | $line');
      }
    }
  }

  static String _normalizedLevel(Level level) {
    return _levelMapping[level] ?? 'UNKNOWN';
  }
}
