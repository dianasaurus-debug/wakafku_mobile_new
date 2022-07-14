import 'package:final_project_mobile/models/program.dart';
import 'package:final_project_mobile/screens/program/detail.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';


class PaymentStepper extends StatefulWidget {
  @override
  PaymentStepperState createState() => new PaymentStepperState();
}

class PaymentStepperState extends State<PaymentStepper> {

  int counter = 0;
  List<String> strings = ["Flutter", "Is", "Awesome"];
  String displayedString = "";

  //you can also declare variables like this
  // var counter = 0;
  // var strings = ["Flutter", "Is", "Awesome"];

  void onPressed(){
    setState(() {
      displayedString = strings[counter];
      counter = counter < 2 ? counter+1 : 0;
    });
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
        appBar: new AppBar(title: new Text("Stateful Widget!"), backgroundColor: Colors.deepOrange),
        body: new Container(
            child: new Center(
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(displayedString, style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
                      new Padding(padding: new EdgeInsets.all(15.0)),
                      new RaisedButton(
                          child: new Text("Press me!", style: new TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 20.0)),
                          color: Colors.red,
                          onPressed: onPressed
                      )
                    ]
                )
            )
        )
    );
  }
}
