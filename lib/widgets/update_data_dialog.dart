import 'package:Dachboden/routes/werkzeugsuche_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateDataDialog extends StatefulWidget {
  UpdateDataDialog(this.searchResult);

  final Document searchResult;

  @override
  _UpdateDataDialogState createState() => _UpdateDataDialogState();
}

class _UpdateDataDialogState extends State<UpdateDataDialog> {
  TextEditingController nameController;
  TextEditingController boxIDController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.searchResult.name);
    boxIDController = TextEditingController(text: widget.searchResult.boxID);
  }

  void updateData() {
    Firestore.instance
        .collection('tools')
        .document(widget.searchResult.documentID)
        .updateData(
      {
        'name': nameController.text,
        'boxID': boxIDController.text,
      },
    );
  }

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
              textCapitalization: TextCapitalization.characters,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: boxIDController,
              decoration: InputDecoration(hintText: 'Ort'),
              textCapitalization: TextCapitalization.characters,
            ),
          ),
        ],
      ),
      title: Text(
        'Werkzeug bearbeiten',
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
              updateData();
              Navigator.of(context).pop();
            },
            child: Text('OK'))
      ],
    );
  }
}
