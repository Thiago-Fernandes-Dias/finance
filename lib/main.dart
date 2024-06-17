import 'package:finance/firebase_options.dart';
import 'package:finance/src/application/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'src/application/app_root.dart';

Future<void> main() async {
  runApp(const Splash());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AppRoot());
}
