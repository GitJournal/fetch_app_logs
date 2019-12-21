package io.gitjournal.fetch_app_logs;

import androidx.annotation.NonNull;

import android.content.Context;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import io.flutter.util.PathUtils;

public class FetchAppLogsPlugin implements FlutterPlugin, MethodCallHandler {
    final static String CHANNEL_NAME = "io.gitjournal/fetch_app_logs";
    private Context context;
    static private MethodChannel channel;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), CHANNEL_NAME);
        context = flutterPluginBinding.getApplicationContext();
        channel.setMethodCallHandler(this);
    }

    public static void registerWith(Registrar registrar) {
        FetchAppLogsPlugin instance = new FetchAppLogsPlugin();
        instance.channel = new MethodChannel(registrar.messenger(), CHANNEL_NAME);
        instance.context = registrar.context();
        instance.channel.setMethodCallHandler(instance);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (!call.method.equals("dumpAppLogs")) {
            result.notImplemented();
        }

        final String filesDir = PathUtils.getFilesDir(context);
        String filePath = filesDir + "/app-logs.txt";

        try {
            LogDumper.dumpLogs(filePath);
        } catch (Exception e) {
            e.printStackTrace();
            result.error("FAILED", e.toString(), null);
            return;
        }

        result.success(filePath);
        return;
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    }
}
