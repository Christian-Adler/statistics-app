import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../generated/l10n.dart';
import '../../models/app_info.dart';

class DailyFiles {
  static Directory? _appDocumentsDir;
  static Directory? _tmpDir;
  static Directory? _logsDir;
  static String _todayLog = '';

  static final List<_MsgQueueItem> _msgQueue = [];
  static bool _timerSet = false;

  static Future<void> init() async {
    _appDocumentsDir = await getApplicationDocumentsDirectory();
    _tmpDir = await getTemporaryDirectory();
    final appDocDir = _appDocumentsDir;
    if (appDocDir == null) return;
    var logsDir = Directory('${appDocDir.path}/logs');
    if (!(await logsDir.exists())) logsDir = await logsDir.create();
    _logsDir = logsDir;

    _writeLogStart();

    try {
      await _clearTmpDir();
    } catch (err) {
      writeToFile(err.toString());
    }
  }

  static void _writeLogStart() {
    writeToFile('START\n-------------------------\n App Version ${AppInfo.version}\n-------------------------');
  }

  /// liefert die Dateinamen unter logs (ohne die Endung .txt)
  static Future<List<String>> listLogFileNames() async {
    final logs = _logsDir;
    List<String> result = [];
    if (logs == null) return result;
    await logs.list().forEach((element) {
      // result.add(element.path);
      result.add(element.path.split(Platform.pathSeparator).last);
    });
    return result.reversed.toList();
  }

  static Future<List<String>> listTmpFileNames() async {
    final logs = _tmpDir;
    List<String> result = [];
    if (logs == null) return result;
    await logs.list().forEach((element) {
      result.add(element.path.split(Platform.pathSeparator).last);
    });
    return result.reversed.toList();
  }

  static bool logsDirAvailable() {
    return _logsDir != null;
  }

  static void writeToFile(String value) {
    final dateTime = DateTime.now();
    final ms = dateTime.millisecond.toString().padLeft(3, '0');
    final msgQueueItem = _MsgQueueItem(
        DateFormat('yyyy-MM-dd').format(dateTime), '${DateFormat('HH:mm:ss').format(dateTime)}.$ms', value);
    _msgQueue.add(msgQueueItem);
    if (_timerSet) return;
    _timerSet = true;
    Timer(
      const Duration(milliseconds: 1000),
      () async {
        final messages = [..._msgQueue];
        _msgQueue.clear();
        _timerSet = false;
        if (messages.isEmpty) return;
        try {
          await _writeToTodayFile(messages);
        } catch (err) {
          if (kDebugMode) {
            print('Failed to write logs!\n\n$err');
          }
        }
      },
    );
  }

  static Future<void> _writeToTodayFile(List<_MsgQueueItem> msgQueueItems) async {
    final logsDir = _logsDir;
    if (logsDir == null) return;

    if (msgQueueItems.isEmpty) return;

    var soFarDate = msgQueueItems.first.date;
    var todayLog = '$soFarDate.txt';
    _todayLog = todayLog;

    var logFile = File('${logsDir.path}/$todayLog');
    var sink = logFile.openWrite(mode: FileMode.append);

    for (var i = 0; i < msgQueueItems.length; ++i) {
      var msgQueueItem = msgQueueItems[i];

      // check for new date
      if (soFarDate != msgQueueItem.date) {
        await sink.flush();
        await sink.close();

        soFarDate = msgQueueItems.first.date;
        todayLog = '$soFarDate.txt';
        _todayLog = todayLog;

        logFile = File('${logsDir.path}/$todayLog');
        sink = logFile.openWrite(mode: FileMode.append);
      }

      sink.write('[${msgQueueItem.date} ${msgQueueItem.time}] ${msgQueueItem.text}\n');
    }

    await sink.flush();
    await sink.close();
  }

  static Future<String> readLog(String filename, BuildContext context, bool addNLAfterLogLevel) async {
    final logsDir = _logsDir;
    if (logsDir == null) return 'No logs dir set/found!';
    String fn = filename;
    final logFile = File('${logsDir.path}/$fn');

    var logMsgFileNotFound = S.of(context).logMsgErrorFileNotFound(filename);
    if (!await logFile.exists()) return logMsgFileNotFound;

    final lines = await logFile.readAsLines();
    if (addNLAfterLogLevel) {
      return lines.map((e) => e.replaceFirst(' | ', '\n')).join('\n');
    }
    return lines.join('\n');
  }

  static Future<List<String>> readLogLines(String filename, BuildContext context, bool addNLAfterLogLevel) async {
    final logsDir = _logsDir;
    if (logsDir == null) return ['No logs dir set/found!'];
    String fn = filename;
    final logFile = File('${logsDir.path}/$fn');

    final logMsgFileNotFound = S.of(context).logMsgErrorFileNotFound(filename);
    if (!await logFile.exists()) return [logMsgFileNotFound];

    final lines = await logFile.readAsLines();

    List<String> result = [];
    String actString = '';

    for (var line in lines) {
      if (line.startsWith('[') && actString.isNotEmpty) {
        result.add(actString);
        actString = '';
      }

      String l = line;
      if (actString.isEmpty && addNLAfterLogLevel) {
        l = l.replaceFirst(' (', '\n(');
        l = l.replaceFirst(') ', ')\n');
      }

      if (actString.isNotEmpty) actString += '\n';
      actString += l;
    }

    if (actString.isNotEmpty) {
      result.add(actString);
    }

    return result;
  }

  static String getFullLogPath(String filename) {
    final logsDir = _logsDir;
    if (logsDir == null) return 'No logs dir set/found!';
    String fn = filename;
    return '${logsDir.path}/$fn';
  }

  static Future<void> deleteLog(String filename) async {
    final logsDir = _logsDir;
    if (logsDir == null) return;
    await File('${logsDir.path}/$filename').delete();

    // Aktuelles File entfernen? Dann neues File anlegen...
    if (filename == _todayLog) {
      _writeLogStart();
    }
  }

  static Future<void> deleteAllLogs() async {
    final logsDir = _logsDir;
    if (logsDir == null) return;
    _logsDir = null;
    await logsDir.delete(recursive: true);
    await init();
  }

  static Future<void> _clearTmpDir() async {
    final tmpDir = _tmpDir;
    if (tmpDir == null) return;
    tmpDir.list(recursive: true).listen((file) async {
      if (file is File) {
        if (kDebugMode) {
          print('del tmp file $file');
        }
        await file.delete();
      }
    });
  }

  static Future<String> zipAllLogs() async {
    final tmpDir = _tmpDir;
    if (tmpDir == null) throw 'No tmp dir available!';
    final logsDir = _logsDir;
    if (logsDir == null) throw 'No log dir found!';
    var zipFile = File('${tmpDir.path}/logs_${DateFormat('yyyy-MM-dd_HH_mm_ss').format(DateTime.now())}.zip');
    await ZipFile.createFromDirectory(sourceDir: logsDir, zipFile: zipFile, recurseSubDirs: true);
    return zipFile.path;
  }
}

class _MsgQueueItem {
  _MsgQueueItem(this.date, this.time, this.text);

  final String date;
  final String time;
  final String text;
}
