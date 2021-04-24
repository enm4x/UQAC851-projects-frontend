import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/models/user.dart';
import 'package:app/screens/dashboard.dart';

import 'package:app/Tools/auth.dart';

class VerificationPage extends StatefulWidget {
  VerificationPage({Key? key, required this.userInstance}) : super(key: key);
  final User userInstance;

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailverifTokenInputController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.

    emailverifTokenInputController.dispose();
    super.dispose();
  }

  Future<bool> isUserVerify(User userObj) async {
    var res = await isUserEmailVerified(userObj);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
        child: Scaffold(
            backgroundColor: Color(0xFF2e3440),
            body: Container(
              child: Center(
                  child: Padding(
                padding: EdgeInsets.all(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: emailverifTokenInputController,
                        style: TextStyle(color: Color(0xFF2e3440)),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            filled: true,
                            fillColor: Color(0xFFd8dee9),
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0), borderSide: BorderSide.none),
                            hintStyle: TextStyle(color: Color(0xFF2e3440)),
                            hintText: "Paste verification token",
                            prefixIcon: Icon(
                              Icons.security,
                              color: Color(0xFF2e3440),
                            )),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your verification token';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50, vertical: 15))),
                      onPressed: () async {
                        final snackBadTokenError = SnackBar(
                          content: Text("Error bad token"),
                          behavior: SnackBarBehavior.floating,
                        );

                        final snackEmailAccountSuccess = SnackBar(
                          content: Text("Email verified & Account created"),
                          behavior: SnackBarBehavior.floating,
                        );

                        final snackAccountCreationError = SnackBar(
                          content: Text("Error : Email verified with succes but account creation error"),
                          behavior: SnackBarBehavior.floating,
                        );

                        var resVerification =
                            await sendUseraccountVerification(widget.userInstance, emailverifTokenInputController.text);
                        if (resVerification == true) {
                          await createUserBankAccount(widget.userInstance)
                              .then((value) => {
                                    widget.userInstance.userAccount = value,
                                    ScaffoldMessenger.of(context).showSnackBar(snackEmailAccountSuccess),
                                    print("--debug \n the account id is : ${widget.userInstance.userAccount}"),
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DashboardPage(userObj: widget.userInstance)),
                                    )
                                  })
                              .onError((error, stackTrace) =>
                                  {ScaffoldMessenger.of(context).showSnackBar(snackAccountCreationError)});
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(snackBadTokenError);
                        }
                      },
                      child: const Text('Send verification'),
                    ),
                  ],
                ),
              )),
            )));
  }
}
