import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:producot_store_locator/model/user.dart';
import 'package:producot_store_locator/ui/homesreen.dart';
import 'package:producot_store_locator/ui/register.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;

class SocialLogin extends StatefulWidget {
  @override
  _SocialLoginState createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {

  final _formKey = GlobalKey<FormState>();
  String username;
  String password;

  // ignore: missing_return
  Future<User> login(ProgressDialog pr, username, password) async{
  const url = 'http://hitwo-api.herokuapp.com/signin';
  var response = await http.post(url, body: {
    'username':username,
    'password': password
  });

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  }else if(response.statusCode == 401){
    pr.update(
      message: '401: ${response.body}'
    );
    Timer(Duration(seconds: 3), (){
      pr.hide().then((isHidden){
        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterUser()));
      });
    });
  }else{
    pr.update(
      message: '${response.statusCode}: ${response.body}'
    );
  }
}

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    ProgressDialog pr;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Register New Account",
      theme: ThemeData(fontFamily: 'VarelaRound'),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Product Locator",
                        style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(60)
                        ),
                      ),
                      Text(
                        "Login Into Your Account Below",
                        style: TextStyle(
                          color: Colors.grey
                        )
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 80)
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Username",
                                  border: OutlineInputBorder(
                                    gapPadding: 3.5,
                                    borderRadius: BorderRadius.circular(3.5)
                                  )
                                ),
                                // ignore: missing_return
                                validator: (value){
                                  if(value.isEmpty){
                                    return "Email or username format is not correct";
                                  }else{
                                    this.username= value;
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  border: OutlineInputBorder(
                                    gapPadding: 3.5,
                                    borderRadius: BorderRadius.circular(3.5)
                                  )
                                ),
                                // ignore: missing_return
                                validator: (value){
                                  if(value.isEmpty){
                                    return "Password format is not correct";
                                  }else{
                                    this.password = value;
                                  }
                                },
                                obscureText: true,
                              )
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: RaisedButton(
                                    onPressed: () async {
                                      if(_formKey.currentState.validate()){
                                        pr = new ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
                                        pr.style(
                                          message: 'Logging In...',
                                          borderRadius: 10.0,
                                          backgroundColor: Colors.white,
                                          progressWidget: SpinKitCircle(color: Colors.blueAccent),
                                          elevation: 10.0,
                                          insetAnimCurve: Curves.easeInOut,
                                          messageTextStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.w600
                                          )
                                        );
                                        pr.show();
                                        var user = await login(pr, this.username, this.password);
                                        if(user.username != null){
                                          pr.update(
                                            message: 'Authentication Succesful.',
                                            progressWidget: SpinKitCircle(color: Colors.greenAccent),
                                            messageTextStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 19.0,
                                              fontWeight: FontWeight.w600
                                            )
                                          );
                                          Timer(Duration(seconds: 2), (){
                                            pr.hide().then((isHidden){
                                              Navigator.pop(context);
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                                            });
                                          });
                                        }
                                      }
                                    },
                                    child: Text("Login"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ),
                    ]
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(top: 90),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MaterialButton(
                        child: Text(
                          "Or register instead",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        color: Colors.grey,
                        onPressed: (){
                          pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
                          pr.style(
                            message: 'Please Wait...',
                            borderRadius: 10.0,
                            backgroundColor: Colors.white,
                            progressWidget: SpinKitCircle(color: Colors.blueAccent),
                            elevation: 10.0,
                            insetAnimCurve: Curves.easeInOut,
                            messageTextStyle: TextStyle(
                              color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
                          );
                          pr.show();
                          Timer(Duration(seconds: 1), (){
                            pr.hide().then((isHidden){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterUser()));
                            });
                          });
                        },
                      ),
                    ],
                  ),
                )
              ]),
            )
          )
        )
      );
  }
}
