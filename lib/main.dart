import 'package:clean_todo/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'config/logger.dart';
import 'features/features.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await features.preregister();

  runApp(
    ProviderScope(observers: [Logger()], child: const App()),
  );
}
