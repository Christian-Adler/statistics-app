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
  static String _todaysLog = '';

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
      writeToTodayFile(err.toString());
    }
  }

  static void _writeLogStart() {
    writeToTodayFile('START\n---------------------\n App Version ${AppInfo.version}\n---------------------');
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

  static Future<void> writeToTodayFile(String value) async {
    final logsDir = _logsDir;
    if (logsDir == null) return;

    var todayLog = '${DateFormat('yyyy-MM-dd').format(DateTime.now())}.txt';
    _todaysLog = todayLog;

    var myFile = File('${logsDir.path}/$todayLog');
    var sink = myFile.openWrite(mode: FileMode.append);
    sink.write('${DateTime.now()} - $value\n');
    await sink.flush();
    await sink.close();
  }

  static Future<String> readLog(String filename, BuildContext context) async {
    final logsDir = _logsDir;
    if (logsDir == null) return 'No logs dir set/found!';
    String fn = filename;
    final logFile = File('${logsDir.path}/$fn');

    var logMsgFileNotFound = S.of(context).logMsgFileNotFound(filename);
    if (!await logFile.exists()) return logMsgFileNotFound;

    return logFile.readAsString();
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
    if (filename == _todaysLog) {
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
