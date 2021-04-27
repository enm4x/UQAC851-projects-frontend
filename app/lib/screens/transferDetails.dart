import 'package:app/screens/transferPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/models/user.dart';
import 'package:app/models/transfer.dart';

import 'package:app/Tools/client_transfer.dart';

class TransferDetailPage extends StatefulWidget {
  const TransferDetailPage({Key? key, required this.transferData, required this.myUser}) : super(key: key);
  final Transfer transferData;
  final User myUser;
  @override
  _TransferDetailPageState createState() => _TransferDetailPageState();
}

class _TransferDetailPageState extends State<TransferDetailPage> {
  final answerInputController = TextEditingController();
  int numberOfTry = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white.withOpacity(0.8), // set it to false
            body: SingleChildScrollView(
                child: Center(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              const SizedBox(height: 150),
              widget.transferData.verified
                  ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Container(
                          padding: EdgeInsets.all(25),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Card(
                              shadowColor: Colors.green,
                              elevation: 5,
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.money),
                                    title: Text('Transfer ${widget.transferData.id} info'),
                                    subtitle: Text(
                                      'Sender: ${widget.transferData.from}\nReceiver: ${widget.transferData.to} ',
                                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                    ),
                                    isThreeLine: true,
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                        TextFormField(
                                          enabled: false,
                                          initialValue: '${widget.transferData.amount}',
                                          decoration: InputDecoration(
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.blue,
                                                width: 1.0,
                                              ),
                                            ),
                                            labelText: 'Amount',
                                            prefixIcon: Icon(
                                              Icons.query_builder,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        TextFormField(
                                          enabled: false,
                                          initialValue: '${widget.transferData.verified}',
                                          decoration: InputDecoration(
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.blue,
                                                width: 1.0,
                                              ),
                                            ),
                                            labelText: 'Transfer status',
                                            prefixIcon: Icon(
                                              Icons.query_builder,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        TextFormField(
                                          enabled: false,
                                          initialValue: '${widget.transferData.date.substring(0, 10)}',
                                          decoration: InputDecoration(
                                            labelText: 'Transfer date',
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.blue,
                                                width: 1.0,
                                              ),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.date_range,
                                            ),
                                          ),
                                        ),
                                      ])),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Go back'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ]))
                    ])
                  : Column(children: [
                      Container(
                          padding: EdgeInsets.all(25),
                          child: Column(children: [
                            Card(
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.money),
                                    title: Text('Transfer ${widget.transferData.id} info'),
                                    subtitle: Text(
                                      'Sender: ${widget.transferData.from}\nReceiver: ${widget.transferData.to} ',
                                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                    ),
                                    isThreeLine: true,
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(children: [
                                        TextFormField(
                                          enabled: false,
                                          initialValue: '${widget.transferData.amount}',
                                          decoration: InputDecoration(
                                            disabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.blue,
                                                width: 1.0,
                                              ),
                                            ),
                                            labelText: 'Amount',
                                            prefixIcon: Icon(
                                              Icons.query_builder,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          enabled: false,
                                          initialValue: '${widget.transferData.question}',
                                          decoration: InputDecoration(
                                            disabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.blue,
                                                width: 1.0,
                                              ),
                                            ),
                                            labelText: 'Transfer Question',
                                            prefixIcon: Icon(
                                              Icons.query_builder,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        widget.transferData.verificationTry < 3
                                            ? TextFormField(
                                                enabled: widget.transferData.from != widget.myUser.email ? true : false,
                                                controller: answerInputController,
                                                style: TextStyle(color: Color(0xFF2e3440)),
                                                decoration: InputDecoration(
                                                  border: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.blue,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  disabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.red,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  labelText: 'Transfer Answer',
                                                  prefixIcon: Icon(
                                                    Icons.query_builder,
                                                  ),
                                                ),
                                                validator: (String? value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter a valid answer';
                                                  }
                                                  return null;
                                                },
                                              )
                                            : TextFormField(
                                                enabled: false,
                                                controller: answerInputController,
                                                style: TextStyle(color: Color(0xFF2e3440)),
                                                decoration: InputDecoration(
                                                  border: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.blue,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  disabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.red,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  labelText: 'Transfer Answer',
                                                  prefixIcon: Icon(
                                                    Icons.query_builder,
                                                  ),
                                                ),
                                                validator: (String? value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter a valid answer';
                                                  }
                                                  return null;
                                                },
                                              ),
                                      ])),
                                  widget.transferData.verificationTry < 3
                                      ? ButtonBar(
                                          alignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Go back'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                if (widget.transferData.verificationTry < 3) {
                                                  await verifyTransfer(widget.myUser, widget.transferData,
                                                          answerInputController.text)
                                                      .then((value) => Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext context) => TransferPage(
                                                                    userObj: widget.myUser,
                                                                  ))))
                                                      .onError((error, stackTrace) => {
                                                            setState(() {
                                                              widget.transferData.verificationTry =
                                                                  widget.transferData.verificationTry + 1;
                                                            }),
                                                            if (widget.transferData.verificationTry >= 3)
                                                              {
                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                  content: Text("Error : Transfer has been blocked"),
                                                                  behavior: SnackBarBehavior.floating,
                                                                ))
                                                              }
                                                            else
                                                              {
                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                  content: Text("Error : Bad Answer"),
                                                                  behavior: SnackBarBehavior.floating,
                                                                ))
                                                              },
                                                          });
                                                } else {
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                    content: Text("Error : Transfer has been blocked"),
                                                    behavior: SnackBarBehavior.floating,
                                                  ));
                                                }
                                              },
                                              child: const Text('Verify'),
                                            ),
                                          ],
                                        )
                                      : ButtonBar(
                                          alignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Go back'),
                                            ),
                                            if (widget.transferData.from == widget.myUser.email)
                                              TextButton(
                                                onPressed: () async {
                                                  print("bonjour groupe");
                                                  await destroyTransfer(widget.myUser, widget.transferData)
                                                      .then((value) => Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext context) => TransferPage(
                                                                    userObj: widget.myUser,
                                                                  ))));
                                                },
                                                child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                              ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ])),
                      Container(padding: EdgeInsets.all(25), child: Column(children: []))
                    ])
            ])))));
  }
}
