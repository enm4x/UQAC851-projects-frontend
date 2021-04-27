import 'package:app/screens/transferPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/Tools/client_transfer.dart';
import 'package:app/models/user.dart';
import 'package:app/models/transfer.dart';

import 'package:app/components/AppDrawer.dart';

class NewTransferPage extends StatefulWidget {
  const NewTransferPage({Key? key, required this.userObj}) : super(key: key);
  final User userObj;

  @override
  _NewTransferPageState createState() => _NewTransferPageState();
}

// This is the private State class that goes with MyStatefulWidget.
class _NewTransferPageState extends State<NewTransferPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailReceiverInputController = TextEditingController();
  final dateController = TextEditingController();
  final amountInputController = TextEditingController();
  final questionInputController = TextEditingController();
  final answerInputController = TextEditingController();

  var transferData = new TransferToSend(
    to: '',
    amount: 0,
    instant: false,
    scheduled: false,
    date: '',
    question: '',
    answer: '',
  );

  DateTime selectedDate = DateTime.now();

  Future<DateTime> selectDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2100));

    if (picked != null && picked != selectedDate) {
      return picked;
    } else if (picked == selectedDate) {
      return selectedDate;
    }

    throw Exception("error");
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailReceiverInputController.dispose();
    dateController.dispose();
    amountInputController.dispose();
    questionInputController.dispose();
    answerInputController.dispose();
    super.dispose();
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  var task = {'name': "", 'date': DateTime.now()};

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
        child: Scaffold(
            // resizeToAvoidBottomInset: false,
            drawer: AppDrawer(
              userObj: widget.userObj,
            ),
            appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.blue, //change your color here
                ),
                backgroundColor: Colors.white38,
                elevation: 0.0,
                title: Text(
                  "New Transfer",
                  style: TextStyle(color: Colors.black),
                ),
                centerTitle: true),
            body: ListView(shrinkWrap: true, padding: EdgeInsets.all(15.0), children: <Widget>[
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          controller: emailReceiverInputController,
                          style: TextStyle(color: Color(0xFF2e3440)),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              filled: true,
                              fillColor: Color(0xFFd8dee9),
                              border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0), borderSide: BorderSide.none),
                              hintStyle: TextStyle(color: Color(0xFF2e3440)),
                              hintText: "Receiver Email ",
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color(0xFF2e3440),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty || isEmail(value) == false) {
                              return 'Please enter a valid email';
                            } else if (value == widget.userObj.email) {
                              return "Dont be silly, enter a correct email";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          onTap: () async => {
                            FocusScope.of(context).requestFocus(new FocusNode()),
                            await selectDate(context)
                                .then((value) => {dateController.text = value.toString().substring(0, 10)}),
                          },
                          controller: dateController,
                          style: TextStyle(color: Color(0xFF2e3440)),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFd8dee9),
                              border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0), borderSide: BorderSide.none),
                              hintStyle: TextStyle(color: Color(0xFF2e3440)),
                              hintText: "Date",
                              prefixIcon: Icon(
                                Icons.calendar_today,
                                color: Color(0xFF2e3440),
                              )),
                          validator: (value) {
                            if (value == null) return "Please enter a date for your transfer";
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFd8dee9),
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0), borderSide: BorderSide.none),
                            hintStyle: TextStyle(color: Color(0xFF2e3440)),
                          ),
                          hint: Text("dropdown"),
                          items: [
                            DropdownMenuItem<String>(
                              child: Text('instant'),
                              value: 'one',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('delayed'),
                              value: 'two',
                            ),
                          ],
                          value: "one",
                          onChanged: (value) => {value = value},
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: amountInputController,
                          style: TextStyle(color: Color(0xFF2e3440)),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFd8dee9),
                              border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0), borderSide: BorderSide.none),
                              hintStyle: TextStyle(color: Color(0xFF2e3440)),
                              hintText: "Amount",
                              prefixIcon: Icon(
                                Icons.attach_money,
                                color: Color(0xFF2e3440),
                              )),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid amount';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: questionInputController,
                          style: TextStyle(color: Color(0xFF2e3440)),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFd8dee9),
                              border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0), borderSide: BorderSide.none),
                              hintStyle: TextStyle(color: Color(0xFF2e3440)),
                              hintText: "Your question",
                              prefixIcon: Icon(
                                Icons.policy,
                                color: Color(0xFF2e3440),
                              )),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid question';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: answerInputController,
                          obscureText: true,
                          style: TextStyle(color: Color(0xFF2e3440)),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFd8dee9),
                              border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0), borderSide: BorderSide.none),
                              hintStyle: TextStyle(color: Color(0xFF2e3440)),
                              hintText: "Answer to your question",
                              prefixIcon: Icon(
                                Icons.spellcheck,
                                color: Color(0xFF2e3440),
                              )),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid answer';
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
                              final snackLoginError = SnackBar(
                                content: Text("Error while sending transfer"),
                                behavior: SnackBarBehavior.floating,
                              );
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  transferData.amount = int.parse(amountInputController.text);
                                  transferData.date = "2021-04-25";
                                  transferData.to = emailReceiverInputController.text;
                                  transferData.instant = true;
                                  transferData.question = questionInputController.text;
                                  transferData.answer = answerInputController.text;
                                });
                                // print(transferData.toString());
                                await sendTransfer(widget.userObj, transferData)
                                    .then((value) => {
                                          if (value == "201")
                                            {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext context) => TransferPage(
                                                            userObj: widget.userObj,
                                                          )))
                                            }
                                        })
                                    .catchError((e) {
                                  print("Got error : $e");
                                  ScaffoldMessenger.of(context).showSnackBar(snackLoginError);
                                });
                              }
                            },
                            child: const Text('Send transfer'),
                          ),
                        ),
                      ],
                    ),
                  ))
            ])));
  }
}
