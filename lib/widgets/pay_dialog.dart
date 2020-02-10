import 'package:Dachboden/notifier/drinks_notifier.dart';
import 'package:Dachboden/notifier/tips_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PayDialog extends StatefulWidget {
  @override
  _PayDialogState createState() => _PayDialogState();
}

class _PayDialogState extends State<PayDialog> {
  Widget _buildQRImage() {
    final drinks = Provider.of<DrinksNotifier>(context).drinks;
    final tips = Provider.of<TipsNotifier>(context);
    return QrImage(
      data:
          "https://www.paypal.me/dachbodenH12/${drinks.map((d) => d.price * d.buyCounter).reduce((d1, d2) => d1 + d2) + tips.price * tips.tipCounter}",
      version: QrVersions.auto,
      size: 200.0,
    );
  }

  Widget _priceText() {
    final drinks = Provider.of<DrinksNotifier>(context).drinks;
    final tips = Provider.of<TipsNotifier>(context);
    return Text(
      '${drinks.map((d) => d.price * d.buyCounter).reduce((d1, d2) => d1 + d2) + tips.price * tips.tipCounter}€',
      style:
          TextStyle(fontSize: 33, fontFamily: 'lacquer', color: Colors.black),
    );
  }

  Widget _buildTipButton() {
    return FlatButton(
      color: Color(0x7700aa00),
      onPressed: () {
        Provider.of<TipsNotifier>(context, listen: false).increment();
      },
      child: Text(
        'Tip 0,5€',
        style:
            TextStyle(fontSize: 24, fontFamily: 'lacquer', color: Colors.white),
      ),
    );
  }

  Widget _buildResetButton() {
    return FlatButton(
      onPressed: () {
        Provider.of<DrinksNotifier>(context, listen: false).reset();
        Provider.of<TipsNotifier>(context, listen: false).reset();
        Navigator.pop(context);
      },
      child: Text(
        "reset",
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'lacquer',
          color: Colors.black54,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            padding: EdgeInsets.all(50),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('dialog_paper.png'),
                fit: BoxFit.contain,
              ),
            ),
            child: GestureDetector(
              onTap: () => null,
              child: Center(
                heightFactor: 1.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _buildQRImage(),
                    _priceText(),
                    Row(
                      children: <Widget>[
                        _buildResetButton(),
                        Expanded(
                          child: _buildTipButton(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
