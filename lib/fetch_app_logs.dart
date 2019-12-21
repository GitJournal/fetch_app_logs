import 'dart:async';

import 'package:flutter/services.dart';

class FetchAppLogs {
  static const MethodChannel _channel =
      const MethodChannel('io.gitjournal/fetch_app_logs');

  static Future<String> dumpAppLogsToFile() async {
    return await _channel.invokeMethod('dumpAppLogs');
  }
}
