import 'package:flutter/material.dart';
import 'package:app/Tools/auth.dart';
import 'package:app/models/user.dart';
import 'package:app/screens/dashboard.dart';

class FormSignup extends StatefulWidget {
  const FormSignup({Key? key, required this.userObj}) : super(key: key);
  final User userObj;

  @override
  _FormSignupWidgetState createState() => _FormSignupWidgetState();
}

// This is the private State class that goes with MyStatefulWidget.
class _FormSignupWidgetState extends State<FormSignup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final firstNameInputController = TextEditingController();
  final lastNameInputController = TextEditingController();
  final emailInputController = TextEditingController();
  final pwdInputController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    firstNameInputController.dispose();
    lastNameInputController.dispose();
    emailInputController.dispose();
    pwdInputController.dispose();
    super.dispose();
  }

  Future<int> performRegistration(String firstname, String lastname, String email, String password) async {
    setState(() => {updateUserObj()});
    await userRegistration(widget.userObj.email, pwdInputController.text);
    print("registration is sucessful");
    await userConnection(widget.userObj.email, pwdInputController.text).then((value) => widget.userObj.token = value);
    print("userconnection was succesful");
    await updateUserInfo(widget.userObj);
    return 0;
  }

  void updateUserObj() {
    widget.userObj.firstName = firstNameInputController.text;
    widget.userObj.lastName = lastNameInputController.text;
    widget.userObj.email = emailInputController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: firstNameInputController,
                style: TextStyle(color: Color(0xFF2e3440)),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    filled: true,
                    fillColor: Color(0xFFd8dee9),
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0), borderSide: BorderSide.none),
                    hintStyle: TextStyle(color: Color(0xFF2e3440)),
                    hintText: "First name",
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xFF2e3440),
                    )),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: lastNameInputController,
                style: TextStyle(color: Color(0xFF2e3440)),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    filled: true,
                    fillColor: Color(0xFFd8dee9),
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0), borderSide: BorderSide.none),
                    hintStyle: TextStyle(color: Color(0xFF2e3440)),
                    hintText: "Last name",
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xFF2e3440),
                    )),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: emailInputController,
                style: TextStyle(color: Color(0xFF2e3440)),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    filled: true,
                    fillColor: Color(0xFFd8dee9),
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0), borderSide: BorderSide.none),
                    hintStyle: TextStyle(color: Color(0xFF2e3440)),
                    hintText: "Email adress",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color(0xFF2e3440),
                    )),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: pwdInputController,
                obscureText: true,
                style: TextStyle(color: Color(0xFF2e3440)),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFd8dee9),
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0), borderSide: BorderSide.none),
                    hintStyle: TextStyle(color: Color(0xFF2e3440)),
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color(0xFF2e3440),
                    )),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50, vertical: 15))),
                  onPressed: () async {
                    final snackRegistrationSuccess = SnackBar(
                      content: Text("You've been registered succesfuly"),
                      behavior: SnackBarBehavior.floating,
                    );

                    final snackRegistrationError = SnackBar(
                      content: Text("You've been registered succesfuly"),
                      behavior: SnackBarBehavior.floating,
                    );
                    if (_formKey.currentState!.validate()) {
                      await performRegistration(firstNameInputController.text, lastNameInputController.text,
                              emailInputController.text, pwdInputController.text)
                          .then((value) => {
                                ScaffoldMessenger.of(context).showSnackBar(snackRegistrationSuccess),
                                Navigator.pop(context)
                              })
                          .catchError((e) {
                        print("$e");
                        print("perform registration error");
                        ScaffoldMessenger.of(context).showSnackBar(snackRegistrationError);
                      });
                    }
                  },
                  child: const Text('Register'),
                ),
              ),
            ],
          ),
        ));
  }
}
