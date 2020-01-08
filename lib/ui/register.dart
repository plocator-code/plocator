import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:producot_store_locator/model/user.dart';
import 'package:producot_store_locator/ui/homesreen.dart';
import 'package:producot_store_locator/ui/sociallogin.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {

  final _formKey = GlobalKey<FormState>();
  String username;
  String email;
  String password;
  String mobileNumber;
  
  // ignore: missing_return
  Future<User> register(ProgressDialog pr, username, email, mobileNumber, password) async{
  const url = 'http://hitwo-api.herokuapp.com/signup';
  var response = await http.post(url, body: {
    'username':username,
    'email': email,
    'mobileNumber': mobileNumber,
    'password': password
  });

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  }else if(response.statusCode == 401){
    pr.update(
      message: 'User exists. Please login',
      progressWidget: SpinKitCircle(color: Colors.redAccent),
      messageTextStyle: TextStyle(
        color: Colors.red,
        fontSize: 19.0,
        fontWeight: FontWeight.w600
      )
    );
    Timer(Duration(seconds: 3), (){
      pr.hide().then((isHidden){
        Navigator.push(context, MaterialPageRoute(builder: (context) => SocialLogin()));
      });
    });
  }else{
    pr.update(
      message: 'Server error. Try changing username.',
      progressWidget: SpinKitCircle(color: Colors.redAccent),
      messageTextStyle: TextStyle(
        color: Colors.red,
        fontSize: 19.0,
        fontWeight: FontWeight.w600
      )
    );
    Timer(Duration(seconds: 3), (){
      pr.hide();
    });
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
                        "Register A New Account Below",
                        style: TextStyle(
                          color: Colors.grey
                        )
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40)
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
                                    return "Username format is not correct";
                                  }else{
                                    setState((){
                                      this.username = value;
                                    });
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Email Address",
                                  border: OutlineInputBorder(
                                    gapPadding: 3.5,
                                    borderRadius: BorderRadius.circular(3.5)
                                  )
                                ),
                                // ignore: missing_return
                                validator: (value){
                                  if(value.isEmpty){
                                    return "Email Address format is not correct";
                                  }else{
                                    setState((){
                                      this.email = value;
                                    });
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Mobile Number",
                                  border: OutlineInputBorder(
                                    gapPadding: 3.5,
                                    borderRadius: BorderRadius.circular(3.5)
                                  )
                                ),
                                // ignore: missing_return
                                validator: (value){
                                  if(value.isEmpty || value.length < 10){
                                    return "Mobile Number format is not correct";
                                  }else{
                                    setState((){
                                      this.mobileNumber = value;
                                    });
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
                                    setState((){
                                      this.password = value;
                                    });
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
                                          message: 'Creating Account',
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
                                        var user = await register(pr, this.username, this.email, this.mobileNumber, this.password);
                                        if(user.username != null){
                                          pr.update(
                                            message: 'Account created.',
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
                                    child: Text("Register"),
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
                  padding: EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MaterialButton(
                        child: Text(
                          "I have an account already",
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
                              Navigator.pop(context);
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
