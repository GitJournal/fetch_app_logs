import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fetch_app_logs/fetch_app_logs.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String logText = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(logText),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Get Logs"),
                      onPressed: _loadLogs,
                    ),
                    RaisedButton(
                      child: Text("Clear Screen"),
                      onPressed: () {
                        setState(() {
                          logText = "";
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loadLogs() async {
    var filePath = await FetchAppLogs.dumpAppLogsToFile();
    var logFile = File(filePath);
    var contents = await logFile.readAsString();
    setState(() {
      logText = contents;
    });
  }
}
