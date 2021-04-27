import 'package:app/Tools/methods.dart';
import 'package:app/Tools/retrieve.dart';
import 'package:app/Tools/auth.dart';
import 'package:app/components/AppDrawer.dart';
import 'package:app/models/operation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/models/user.dart';
import 'StatementsPage.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key, required this.userObj}) : super(key: key);
  final User userObj;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<int> balance;
  late Future<List<Operation>> operations;

  @override
  void initState() {
    super.initState();
    balance = initializeBankAccount();
    operations = initOperations();
  }

  Future<int> initializeBankAccount() async {
    return await getUserAccountBalance(widget.userObj);
  }

  Future<List<Operation>> initOperations() async {
    return await getOperations(widget.userObj);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
        child: Scaffold(
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
                  "Accounts",
                  style: TextStyle(color: Colors.black),
                ),
                centerTitle: true),
            body: Center(
                child: Container(
              color: Colors.white,
              child: Column(children: <Widget>[
                FutureBuilder<int>(
                  future: balance,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StatementsPage(
                                      userObj: widget.userObj,
                                    )),
                          );
                        },
                        child: Container(
                          color: Colors.grey,
                          child: topArea(snapshot.data!.toString()),
                        ),
                      );
                    } else {
                      return Center(
                          child: Container(
                        child: CircularProgressIndicator(),
                        padding: EdgeInsets.all(50),
                      ));
                    }
                  },
                ),
                FutureBuilder<List<Operation>>(
                  future: operations,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return displayOperationList(snapshot.data!, widget.userObj.email);
                    } else {
                      return Center(
                          child: Container(
                        child: CircularProgressIndicator(),
                        padding: EdgeInsets.all(50),
                      ));
                    }
                  },
                )
              ]),
            ))));
  }
}
