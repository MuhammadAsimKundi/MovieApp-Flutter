import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/Screens/splash%20screen.dart';
import 'package:movieapp/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/watchlater controler.dart';
import 'dart:io' show Platform;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WatchLaterProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splas_screen(),
      ),
    );
  }
}
