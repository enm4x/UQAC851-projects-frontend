import 'package:flutter/material.dart';

Card topArea(String savings ) => Card(
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
    
Container displayAccoutList() => Container(
      child: Column(
        children: <Widget>[
          accountItems("Trevello App", r"- $ 4,946.00", "28-04-16", "Invoice",
              oddColour: const Color(0xFFF7F7F9)),
          accountItems(
              "Creative Studios", r"+ $ 5,428.00", "26-04-16", "Transfer"),
          accountItems("Amazon EU", r"+ $ 746.00", "25-04-216", "Payment",
              oddColour: const Color(0xFFF7F7F9)),
          accountItems(
              "Creative Studios", r"+ $ 14,526.00", "16-04-16", "Payment"),
          accountItems(
              "Book Hub Society", r"- $ 2,876.00", "04-04-16", "Invoice",
              oddColour: const Color(0xFFF7F7F9)),
          accountItems(
              "Uber Eat", r"- $ 20.00", "04-04-16", "Payment")
        ],
      ),
    );

Container accountItems(
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
              Text(charge, style: TextStyle(fontSize: 16.0))
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