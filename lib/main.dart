import 'package:firebase_core/firebase_core.dart';
import 'package:garbh/services/notif_service.dart';
import 'package:garbh/splashscreen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationService().initNotification();
  tz.initializeTimeZones();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor mySwatchColor = Colors.red;

    return MaterialApp(
      title: 'Garbh',
      home: const Splashscreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: mySwatchColor,
        colorScheme: const ColorScheme.light(
          primary: Colors.red,
          background: Colors.white,
          onPrimary: Colors.white,
        ),
        textTheme: GoogleFonts.rubikTextTheme(
          Theme.of(context).textTheme,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
