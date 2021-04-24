import 'package:app/Tools/methods.dart';
import 'package:app/Tools/retrieve.dart';
import 'package:app/components/AppDrawer.dart';
import 'package:app/models/bankAccount.dart';
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
  late BankAccount bankAccount;

  Future<BankAccount> initializeBankAccount() async {
    return await getBankAccount(widget.userObj);
  }

  Future<List<Operation>> initOperations() async {
    return await getOperations(widget.userObj, bankAccount);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
        child: Scaffold(
            drawer: AppDrawer(),
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
            body: Container(
              child: Column(children: <Widget>[
                FutureBuilder<BankAccount>(
                  future: initializeBankAccount(),
                  builder: (BuildContext context, AsyncSnapshot<BankAccount> snapshot) {
                    if (snapshot.hasData) {
                      bankAccount = snapshot.data!;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => StatementsPage()),
                          );
                        },
                        child: Container(
                          color: Colors.grey,
                          child: topArea(snapshot.data!.balance.toString()),
                        ),
                      );
                    } else {
                      return Text('Calculating answer...');
                    }
                  },
                ),
                FutureBuilder<List<Operation>>(
                  future: initOperations(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Operation>> snapshot) {
                    if (snapshot.hasData) {
                      return displayOperationList(snapshot.data!);
                    } else {
                      return Text('No Recent Operation');
                    }
                  },
                )
              ]),
            )));
  }
}
