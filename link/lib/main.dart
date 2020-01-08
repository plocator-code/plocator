import 'package:flutter/material.dart';
import 'package:link/screens/onboarding_screen.dart';
import 'package:link/screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Locator',
      theme: ThemeData(fontFamily: 'VarelaRound'),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{'/Login': (BuildContext context) => new Onboarding()},
    );
  }
}
