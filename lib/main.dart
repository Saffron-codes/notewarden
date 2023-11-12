import 'package:flutter/material.dart';
import 'package:note_warden/features/skeleton/presentation/skeleton.dart';
import 'injection_container.dart' as di;
import 'package:window_manager/window_manager.dart';
// import 'injection_container.dart' as di;

// import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(800, 600),
    title: "NoteWarden",
    center: true,
    // backgroundColor: Colors.transparent,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.setPreventClose(true);
    await windowManager.focus();
  });

  runApp(const NoteWardenWinApp());
}
