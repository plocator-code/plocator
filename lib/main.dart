import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:producot_store_locator/ui/sociallogin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Locator',
      theme: ThemeData(fontFamily: 'VarelaRound'),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{'/Login': (BuildContext context) => new SocialLogin()},
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/Login');
  }

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 10), navigationPage);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.redAccent
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Image(
                          image: AssetImage('assets/images/icons-shop-location-1.png')
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        "Product Locator",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold
                        )
                      )
                    ]
                  )
                )
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SpinKitCircle(color: Colors.white),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0)
                    ),
                    Text(
                        "Every Product Within Your Reach",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700
                      )
                    )
                  ],
                )
              )
            ],
          )
        ]
      )
    );
  }
}
