import 'package:app/models/operation.dart';
import 'package:flutter/material.dart';

Card topArea(String savings) => Card(
      margin: EdgeInsets.all(15.0),
      elevation: 1.0,
      child: Container(
          decoration: BoxDecoration(gradient: RadialGradient(colors: [Color(0xFF015FFF), Color(0xFF015FFF)])),
          padding: EdgeInsets.all(5.0),
          // color: Color(0xFF015FFF),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text("Savings",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        )),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(r"$ " + savings, style: TextStyle(color: Colors.white, fontSize: 24.0)),
                ),
              ),
              SizedBox(height: 10.0),
            ],
          )),
    );

Container displayOperationList(List<Operation> operationsList, String accountEmail) {
  if (operationsList.length >= 6) {
    return Container(
        child: Column(children: <Widget>[for (var i = 0; i < 6; i++) operationItems(operationsList, i, accountEmail)]));
  } else {
    return new Container(
        child: Column(children: <Widget>[
      for (var i = 0; i < operationsList.length; i++) operationItems(operationsList, i, accountEmail),
    ]));
  }
}

Container operationItems(List<Operation> operationsList, int index, String accountEmail,
    {Color oddColour = Colors.white}) {
  return Container(
    decoration: BoxDecoration(color: oddColour),
    padding: EdgeInsets.only(top: 21.8, bottom: 21.8, left: 5.0, right: 5.0),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            operationActor(operationsList, index),
            operationAmount(operationsList, index, accountEmail)
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            operationDate(operationsList, index),
            operationType(operationsList, index),
          ],
        ),
      ],
    ),
  );
}

Text operationActor(List<Operation> operationsList, int index) {
  if (operationsList[index].receiverId == 1) {
    return Text("from " + operationsList[index].from, style: TextStyle(fontSize: 16.0));
  } else {
    return Text("to " + operationsList[index].to, style: TextStyle(fontSize: 16.0));
  }
}

Text operationAmount(List<Operation> operationsList, int index, String accountEmail) {
  if (operationsList[index].to == accountEmail) {
    return Text(r"+ $" + operationsList[index].amount.toString(), style: TextStyle(fontSize: 16.0));
  } else {
    return Text(r"- $" + operationsList[index].amount.toString(), style: TextStyle(fontSize: 16.0));
  }
}

Text operationDate(List<Operation> operationsList, int index) {
  return Text(operationsList[index].createdAt, style: TextStyle(color: Colors.grey, fontSize: 14.0));
}

Text operationType(List<Operation> operationsList, int index) {
  if (operationsList[index].invoice == true) {
    return Text("invoice", style: TextStyle(color: Colors.grey, fontSize: 14.0));
  } else {
    return Text("transfer", style: TextStyle(color: Colors.grey, fontSize: 14.0));
  }
}
