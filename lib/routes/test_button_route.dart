import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestButtonRoute extends StatefulWidget {
  TestButtonRoute({Key key}) : super(key: key);

  @override
  _TestButtonRouteState createState() => _TestButtonRouteState();
}

class _TestButtonRouteState extends State<TestButtonRoute> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text('Create Record'),
          onPressed: () {
            createRecord();
          },
        ),
        RaisedButton(
          child: Text('View Record'),
          onPressed: () {
            getData();
          },
        )
      ],
    );
  }

  void createRecord() {
    Firestore.instance
        .collection('tools')
        .document()
        .setData({'name': 'hammer', 'boxID': 'FA14'});
  }

  void getData() {
    Firestore.instance
        .collection('tools')
        .where("name", isEqualTo: "hammer")
        .snapshots()
        .listen((data) => data.documents.forEach((doc) => print(doc["name"])));
  }
}
