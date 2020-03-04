import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:Dachboden/widgets/update_data_dialog.dart';
import 'package:Dachboden/widgets/create_data_dialog.dart';

class Werkzeugsuche extends StatefulWidget {
  Werkzeugsuche({Key key}) : super(key: key);

  @override
  _WerkzeugsucheState createState() => _WerkzeugsucheState();
}

class _WerkzeugsucheState extends State<Werkzeugsuche> {
  Document searchResult;

  void getData(String value) {
    Firestore.instance
        .collection('tools')
        .where("name", isEqualTo: value)
        .snapshots()
        .listen((data) => data.documents.forEach((doc) =>
            setState(() => searchResult = Document.fromDocumentSnapshot(doc))));
  }

  Widget _buildInputTools() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: TextField(
            textCapitalization: TextCapitalization.characters,
        onSubmitted: (value) {
          setState(() => searchResult = null);
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
    );
  }

  Widget _buildRowOptions() {
    return Row(
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
        Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                if (searchResult == null) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Schreib doch ein Werkzeug",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 21.0,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'lacquer'),
                    ),
                    duration: Duration(seconds: 2),
                    backgroundColor: Color(0xffD8AD8A),
                  ));
                  return;
                }
                showDialog(
                  context: context,
                  builder: (context) => UpdateDataDialog(searchResult),
                );
              },
              icon: Icon(Icons.create),
              color: Colors.black38,
            );
          },
        ),
        Spacer(flex: 2),
      ],
    );
  }

  Widget _buildLocationresult() {
    return Text(
      searchResult != null ? 'Ort: ${searchResult.boxID}' : '',
      style: TextStyle(
        fontSize: 26,
        fontFamily: 'lacquer',
        color: Colors.black,
      ),
    );
  }

  Widget _buildHiddenClockButton() {
    return Padding(
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
    );
  }

  Decoration _buildBackgroundImageDecoration() {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage('werkzeugsuche_background.png'),
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: _buildBackgroundImageDecoration(),
        child: Column(
          children: <Widget>[
            _buildHiddenClockButton(),
            Spacer(flex: 4),
            _buildInputTools(),
            _buildRowOptions(),
            _buildLocationresult(),
            Spacer(flex: 6),
          ],
        ),
      ),
    );
  }
}

class Document {
  Document(this.documentID, this.name, this.boxID);
  final String documentID;
  final String name;
  final String boxID;

  Document.fromDocumentSnapshot(DocumentSnapshot doc)
      : this.documentID = doc.documentID,
        this.name = doc.data['name'],
        this.boxID = doc.data['boxID'];
}
