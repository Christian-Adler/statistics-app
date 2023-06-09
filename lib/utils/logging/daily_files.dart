import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/app_info.dart';

class DailyFiles {
  static Directory? _appDocumentsDir;
  static Directory? _logsDir;

  static Future<void> init() async {
    _appDocumentsDir = await getApplicationDocumentsDirectory();
    final appDocDir = _appDocumentsDir;
    if (appDocDir == null) return;
    var logsDir = Directory('${appDocDir.path}/logs');
    if (!(await logsDir.exists())) logsDir = await logsDir.create();
    _logsDir = logsDir;

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

  static bool logsDirAvailable() {
    return _logsDir != null;
  }

  static void writeToTodayFile(String value) async {
    final logsDir = _logsDir;
    if (logsDir == null) return;

    var myFile = File('${logsDir.path}/${DateFormat('yyyy-MM-dd').format(DateTime.now())}.txt');
    var sink = myFile.openWrite(mode: FileMode.append);
    sink.write('${DateTime.now()} - $value\n');
    await sink.flush();
    await sink.close();
  }

  static Future<String> readLog(String filename) async {
    final logsDir = _logsDir;
    if (logsDir == null) return 'No logs dir set/found!';
    String fn = filename;
    final logFile = File('${logsDir.path}/$fn');
    if (!await logFile.exists()) return 'Log file not found!';
    return logFile.readAsString();
  }

  static String getFullLogPath(String filename) {
    final logsDir = _logsDir;
    if (logsDir == null) return 'No logs dir set/found!';
    String fn = filename;
    return '${logsDir.path}/$fn';
  }

  static void deleteLog(String filename) async {
    final logsDir = _logsDir;
    if (logsDir == null) return;
    await File('${logsDir.path}/$filename').delete();
  }

  static void deleteAllLogs() async {
    final logsDir = _logsDir;
    if (logsDir == null) return;
    _logsDir = null;
    await logsDir.delete();
    await init();
  }
}
