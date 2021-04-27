import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/models/user.dart';
import 'package:app/components/logocontainer.dart';
import 'package:app/components/Form-signup.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key, required this.title, required this.userObj}) : super(key: key);
  final String title;
  final User userObj;

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xFF2e3440),
          body: Column(children: <Widget>[
            Flex(
              direction: Axis.vertical,
              children: [
                LogoContainer(),
                Container(
                    child: FormSignup(
                  userObj: widget.userObj,
                ))
              ],
            )
          ]),
        ));
  }
}
