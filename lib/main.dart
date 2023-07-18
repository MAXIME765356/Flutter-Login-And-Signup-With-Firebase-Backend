import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:users/ThemeProvider/theme_provider.dart';
import 'package:users/screens/login_screen.dart';
import 'package:users/screens/main_page.dart';
import 'package:users/screens/register_screen.dart';
import 'package:users/splashscreen/splash_screen.dart';

Future<void> main() async {


  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme:MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

