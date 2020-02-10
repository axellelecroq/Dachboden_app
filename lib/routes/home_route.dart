import 'package:Dachboden/notifier/drinks_notifier.dart';
import 'package:Dachboden/widgets/drink_row.dart';
import 'package:Dachboden/widgets/pay_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatefulWidget {
  HomeRoute({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    final drinks = Provider.of<DrinksNotifier>(context).drinks;
    return Scaffold(
      //     appBar: AppBar(
      //       title: Text(widget.title),
      //     ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Spacer(flex: 5),
            DrinkRow(0),
            DrinkRow(1),
            DrinkRow(2),
            DrinkRow(3),
            DrinkRow(4),
            DrinkRow(5),
            Spacer(),
            Container(
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Summe:',
                          style: TextStyle(
                              fontSize: 33,
                              fontFamily: 'lacquer',
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 104,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${drinks.map((d) => d.price * d.buyCounter).reduce((d1, d2) => d1 + d2)}€',
                            style: TextStyle(
                                fontSize: 33,
                                fontFamily: 'lacquer',
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Spacer(),
                      RaisedButton(
                        elevation: 0,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => PayDialog(),
                          );
                        },
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(1),
                        color: Colors.transparent,
                        child: const Text('Pay',
                            style:
                                TextStyle(fontSize: 40, fontFamily: 'lacquer')),
                      ),
                      Spacer(),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
