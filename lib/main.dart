import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hellocock/screens/root.dart';
import 'package:hellocock/screens/signIn/sign_in_screen.dart';
import 'package:hellocock/screens/splash_screen.dart';
import 'package:hellocock/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  _initNotiSetting();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

void _initNotiSetting() async {
  if (Platform.isIOS) {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final initSettingsAndroid = AndroidInitializationSettings('app_icon');
    final initSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    final initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'hellocock app',
      theme: buildThemeData(),
      //home: SplashScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/signin': (context) => SignInScreen(),
        '/root': (context) => RootPage(),
      },
    );
  }
}
