import 'package:Dachboden/notifier/drinks_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrinkRow extends StatefulWidget {
  DrinkRow(this.index);

  final int index;

  @override
  _DrinkRowState createState() => _DrinkRowState();
}

class _DrinkRowState extends State<DrinkRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Spacer(),
        Text(
          Provider.of<DrinksNotifier>(context).drinks[widget.index].name,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 40, fontFamily: 'lacquer', color: Colors.white),
        ),
        Spacer(),
        SizedBox(
          width: 60,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              Provider.of<DrinksNotifier>(context)
                  .drinks[widget.index]
                  .buyCounter
                  .toString(),
              style: TextStyle(
                  fontSize: 40, fontFamily: 'lacquer', color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.5),
          child: FloatingActionButton(
              onPressed: () {
                Provider.of<DrinksNotifier>(context, listen: false)
                    .increment(widget.index);
              },
              mini: true,
              child: Icon(Icons.add, color: Colors.black),
              backgroundColor: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.all(4.5),
          child: FloatingActionButton(
            onPressed: () {
              Provider.of<DrinksNotifier>(context, listen: false)
                  .decrement(widget.index);
            },
            mini: true,
            child: Icon(Icons.remove, color: Colors.black),
            backgroundColor: Colors.white,
          ),
        ), // This trailing comma
      ],
    );
  }
}
