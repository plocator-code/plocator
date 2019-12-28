import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:producot_store_locator/userdata.dart';

class SocialLogin extends StatefulWidget {
  @override
  _SocialLoginState createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {
  final _formKey = GlobalKey<FormState>();
  LoginData user = new LoginData();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true);

    void _onButtonPressed(title){
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          context: context, builder: (context){
            return Container(
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 25.0)
                  ),
                  Text(
                      "$title",
                    style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(35)
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 45)
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: "Email or Username",
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
                                user.username = value;
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
                                  user.password = value;
                                }
                              },
                              obscureText: true,
                            )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                onPressed: (){
                                  if(_formKey.currentState.validate()){

                                  }
                                  },
                                child: Text("Login"),
                              ),
                              ),
                      ],
                    ),],
                  ),
                )],
              ),
            );
          });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 120.0)
            ),
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
                    "Login or Register With Your Social Account",
                    style: TextStyle(
                      color: Colors.grey
                    )
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 100)
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GoogleSignInButton(
                    onPressed: (){
                      user.type = "google";
                      _onButtonPressed("Google");
                    },
//              darkMode: true,
                    borderRadius: 8.0,
                  ),
                  FacebookSignInButton(
                    onPressed: (){
                      user.type = "facebook";
                      _onButtonPressed("Facebook");
                    },
//              darkMode: true,
                    borderRadius: 8.0,
                  ),
                  TwitterSignInButton(
                    onPressed: (){
                      user.type = "twitter";
                      _onButtonPressed("Twitter");
                    },
//              darkMode: true,
                    borderRadius: 8.0,
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
