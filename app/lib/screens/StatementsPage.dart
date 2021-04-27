//Default import
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//Component import
import 'package:app/components/AppDrawer.dart';
//Models import
import 'package:app/models/user.dart';
import 'package:app/models/operation.dart';
//Tools import
import 'package:app/Tools/retrieve.dart';

class StatementsPage extends StatefulWidget {
  const StatementsPage({Key? key, required this.userObj}) : super(key: key);
  final User userObj;
  @override
  _StatementsPageState createState() => _StatementsPageState();
}

class _StatementsPageState extends State<StatementsPage> {
  late List<Operation> userTransfer;

  Future<List<Operation>> getTransferList() async {
    userTransfer = await getOperations(widget.userObj);

    return userTransfer;
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
                  "Statements",
                  style: TextStyle(color: Colors.black),
                ),
                centerTitle: true),
            body: Center(
                child: FutureBuilder<List<Operation>>(
                    future: getTransferList(),
                    builder: (BuildContext context, AsyncSnapshot<List<Operation>> snapshot) {
                      if (snapshot.hasData) {
                        return ListTileTheme(
                            // contentPadding: const EdgeInsets.all(5.0),
                            // shape: ShapeBorder.lerp(null, null, 10),
                            child: ListView.builder(
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  final item = snapshot.data?[index];

                                  if (item?.invoice == true) {
                                    return Column(children: [
                                      ListTile(
                                        // contentPadding: EdgeInsets.only(left: 15),
                                        leading: Icon(
                                          Icons.description,
                                          color: Colors.green,
                                        ),
                                        trailing: Text(item?.to == widget.userObj.email
                                            ? "+ ${item?.amount}"
                                            : "- ${item?.amount}"),
                                        title:
                                            Text(item?.from == widget.userObj.email ? "${item?.to}" : "${item?.from}"),
                                        subtitle: item?.invoice == true ? Text("Invoice") : Text("Transfer"),
                                        onTap: () => {},
                                      ),
                                      Divider(),
                                    ]);
                                  } else {
                                    return Column(children: [
                                      ListTile(
                                        // contentPadding: EdgeInsets.only(left: 15),
                                        leading: Icon(
                                          Icons.swap_horiz,
                                          color: Colors.blue,
                                        ),
                                        trailing: Text(item?.to == widget.userObj.email
                                            ? "+ ${item?.amount}"
                                            : "- ${item?.amount}"),
                                        title:
                                            Text(item?.from == widget.userObj.email ? "${item?.to}" : "${item?.from}"),
                                        subtitle: item?.invoice == true ? Text("Invoice") : Text("Transfer"),

                                        onTap: () => {},
                                      ),
                                      Divider(),
                                    ]);
                                  }
                                }));
                      } else {
                        return CircularProgressIndicator();
                      }
                    }))));
  }
}
