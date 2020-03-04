import 'package:Dachboden/notifier/drinks_notifier.dart';
import 'package:Dachboden/routes/werkzeugsuche_route.dart';
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
  Decoration _buildBackgroundImageDecoration() {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage('background.png'),
        fit: BoxFit.cover,
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
            Navigator.of(context).push(
              _MyCustomRoute(builder: (context) => Werkzeugsuche()),
            );
          },
          child: SizedBox(height: 50, width: 50),
        ),
      ),
    );
  }

  Widget _buildPayRow() {
    final drinks = Provider.of<DrinksNotifier>(context).drinks;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Summe:',
              style: TextStyle(
                  fontSize: 33, fontFamily: 'lacquer', color: Colors.white),
            ),
          ),
          SizedBox(
            width: 104,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${drinks.map((d) => d.price * d.buyCounter).reduce((d1, d2) => d1 + d2)}€',
                style: TextStyle(
                    fontSize: 33, fontFamily: 'lacquer', color: Colors.white),
              ),
            ),
          ),
          Spacer(flex: 2),
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
                style: TextStyle(fontSize: 40, fontFamily: 'lacquer')),
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _buildBackgroundImageDecoration(),
        child: Column(
          children: <Widget>[
            _buildHiddenClockButton(),
            Spacer(flex: 5),
            DrinkRow(0),
            DrinkRow(1),
            DrinkRow(2),
            DrinkRow(3),
            DrinkRow(4),
            DrinkRow(5),
            Spacer(flex: 2),
            _buildPayRow(),
          ],
        ),
      ),
    );
  }
}

class _MyCustomRoute<T> extends MaterialPageRoute<T> {
  _MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    var begin = Offset(0.0, -1.0);
    var end = Offset(0.0, 0.0);
    var curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(position: animation.drive(tween), child: child);
  }
}
