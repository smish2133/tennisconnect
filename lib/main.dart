library tennisconnect;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'home.dart';
part 'activity.dart';
part 'addactivity.dart';
part 'book.dart';
part 'pd.dart';
part 'profile.dart';
part 'ranking.dart';
part 'tip.dart';
part 'db.dart';
part 'login.dart';

var userData = {};
var userDocId = '';

// Initialize the FlutterLocalNotificationsPlugin instance
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.init();
  await Firebase.initializeApp();

  WidgetsFlutterBinding.ensureInitialized();

  // Configure the initialization settings for the plugin
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings(
          '@mipmap/ic_launcher'); // Replace with your app icon
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(TennisConnectApp());
}

class TennisConnectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TennisConnect',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LoginPage(),
        routes: {
          '/home': (_) => HomePage(),
          '/pd': (_) => MyHomePage(),
          '/profile': (_) => ProfilePage(),
          '/ranking': (_) => RankingPage(sampleUsers),
          '/activity': (_) => ActivityLogApp(),
          '/addactivity': (_) => ActivityPage(),
          '/tip': (_) => TipsPage(),
          '/book': (_) => CourtBooking(),
        });
  }
}
