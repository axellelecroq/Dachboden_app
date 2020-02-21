import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateDataDialog extends StatefulWidget {
  @override
  _CreateDataDialogState createState() => _CreateDataDialogState();
}

void createRecord(String name, String boxID) {
  Firestore.instance
      .collection('tools')
      .document()
      .setData({'name': name, 'boxID': boxID}, merge: true);
}

class _CreateDataDialogState extends State<CreateDataDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController boxIDController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: boxIDController,
              decoration: InputDecoration(hintText: 'Ort'),
            ),
          ),
        ],
      ),
      title: Text(
        'Werkzeug einfügen',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'lacquer',
          color: Colors.black,
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('ABBRECHEN')),
        FlatButton(
            onPressed: () {
              createRecord(nameController.text, boxIDController.text);
              nameController.text = '';
              boxIDController.text = '';
            },
            child: Text('OK'))
      ],
    );
  }
}
