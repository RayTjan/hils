import 'package:flutter/material.dart';
import 'package:hils/shared/shared.dart';
import 'package:hils/ui/pages/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Advanced MAD ToyBox",
      theme: MyTheme.lightTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        // '/': (context) => SplashScreen(),
        Login.routeName: (context) => Login(),
        Register.routeName: (context) => Register(),
        MainMenu.routeName: (context) => MainMenu(),
        // 'history':(context =>History(),
        //History.routeName: (context) => History(),
      },
    );
  }
}
