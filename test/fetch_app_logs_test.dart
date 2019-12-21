import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fetch_app_logs/fetch_app_logs.dart';

void main() {
  const MethodChannel channel = MethodChannel('fetch_app_logs');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FetchAppLogs.platformVersion, '42');
  });
}
