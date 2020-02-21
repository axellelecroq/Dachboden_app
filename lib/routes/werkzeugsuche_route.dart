import 'dart:ffi';

import 'package:Dachboden/routes/home_route.dart';
import 'package:Dachboden/widgets/create_data_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Werkzeugsuche extends StatefulWidget {
  Werkzeugsuche({Key key}) : super(key: key);

  @override
  _WerkzeugsucheState createState() => _WerkzeugsucheState();
}

class _WerkzeugsucheState extends State<Werkzeugsuche> {
  String results = '';

  void getData(String value) {
    Firestore.instance
        .collection('tools')
        .where("name", isEqualTo: value)
        .snapshots()
        .listen((data) => data.documents
            .forEach((doc) => setState(() => results = doc["boxID"])));
  }

  void createRecord() {
    Firestore.instance
        .collection('tools')
        .document()
        .setData({'name': 'penis', 'boxID': 'FA14'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('werkzeugsuche_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Align(
                alignment: Alignment(0.275, 0.00),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: SizedBox(
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
            ),
            Spacer(flex: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: TextField(
                onSubmitted: (value) {
                  setState(() => results = '');
                  getData(value);
                },
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'lacquer',
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'rostige Schrauben',
                  hintStyle: TextStyle(
                    fontSize: 26,
                    fontFamily: 'lacquer',
                    color: Colors.white30,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Spacer(flex: 10),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => CreateDataDialog(),
                    );
                  },
                  icon: Icon(Icons.add),
                  color: Colors.black38,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.create),
                  color: Colors.black38,
                ),
                Spacer(flex: 2),
              ],
            ),
            Text(
              results,
              style: TextStyle(
                fontSize: 26,
                fontFamily: 'lacquer',
                color: Colors.black,
              ),
            ),
            Spacer(flex: 6),
          ],
        ),
      ),
    );
  }
}
