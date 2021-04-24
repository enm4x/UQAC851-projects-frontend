import 'package:app/models/operation.dart';
import 'package:flutter/material.dart';

Card topArea(String savings) => Card(
      margin: EdgeInsets.all(15.0),
      elevation: 1.0,
      child: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  colors: [Color(0xFF015FFF), Color(0xFF015FFF)])),
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
                  child: Text(r"$ " + savings,
                      style: TextStyle(color: Colors.white, fontSize: 24.0)),
                ),
              ),
              SizedBox(height: 10.0),
            ],
          )),
    );

Container displayOperationList(List<Operation> operationsList) {
  if (operationsList.length >= 6) {
    return Container(
        child: Expanded(
            child: ListView(children: <Widget>[
      for (var i = 0; i < 6; i++)
        new Container(
          height: 20,
          child: operationItems(
              operationsList[i].receiverId.toString(),
              operationsList[i].amount.toString(),
              operationsList[i].date,
              "invoice"),
        )
    ])));
  } else {
    return new Container(
        child: Column(children: <Widget>[
      for (var i = 0; i < operationsList.length; i++)
        operationItems(
            operationsList[i].receiverId.toString(),
            operationsList[i].amount.toString(),
            operationsList[i].date,
            "invoice"),
    ]));
  }
}

Container operationItems(
        String item, String charge, String dateString, String type,
        {Color oddColour = Colors.white}) =>
    Container(
      decoration: BoxDecoration(color: oddColour),
      padding: EdgeInsets.only(top: 21.8, bottom: 21.8, left: 5.0, right: 5.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(item, style: TextStyle(fontSize: 16.0)),
              Text(r"+ $" + charge, style: TextStyle(fontSize: 16.0))
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(dateString,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              Text(type, style: TextStyle(color: Colors.grey, fontSize: 14.0))
            ],
          ),
        ],
      ),
    );
