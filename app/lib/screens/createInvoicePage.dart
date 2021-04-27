import 'package:app/Tools/invoiceDataAccess.dart';
import 'package:app/screens/invoicePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/models/user.dart';
import 'package:app/models/invoice.dart';

import 'package:app/components/AppDrawer.dart';

class CreateInvoicePage extends StatefulWidget {
  const CreateInvoicePage({Key? key, required this.userObj}) : super(key: key);
  final User userObj;

  @override
  _CreateInvoicePageState createState() => _CreateInvoicePageState();
}

class _CreateInvoicePageState extends State<CreateInvoicePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailReceiverInputController = TextEditingController();
  final dateController = TextEditingController();
  final amountInputController = TextEditingController();
  final questionInputController = TextEditingController();
  final answerInputController = TextEditingController();

  var invoiceData = new InvoiceToSend(to: '', amount: 0, dueDate: '');

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
                  "New Invoice",
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
                              hintText: "Due Date",
                              prefixIcon: Icon(
                                Icons.calendar_today,
                                color: Color(0xFF2e3440),
                              )),
                          validator: (value) {
                            if (value == null) return "Please enter a date for your invoice";
                            return null;
                          },
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50, vertical: 15))),
                            onPressed: () async {
                              final snackLoginError = SnackBar(
                                content: Text("Error while sending invoice"),
                                behavior: SnackBarBehavior.floating,
                              );
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  invoiceData.amount = int.parse(amountInputController.text);
                                  invoiceData.dueDate = "2021-04-27";
                                  invoiceData.to = emailReceiverInputController.text;
                                });
                                await createInvoice(widget.userObj, invoiceData)
                                    .then((value) => {
                                          if (value == "201")
                                            {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext context) => InvoicePage(
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
                            child: const Text('Send invoice'),
                          ),
                        ),
                      ],
                    ),
                  ))
            ])));
  }
}
