import 'package:Dachboden/notifier/drinks_notifier.dart';
import 'package:Dachboden/notifier/tips_notifier.dart';
import 'package:Dachboden/routes/home_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DrinksNotifier>(create: (_) => DrinksNotifier()),
        ChangeNotifierProvider<TipsNotifier>(create: (_) => TipsNotifier()),
      ],
      child: MaterialApp(
        title: 'Dachboden',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: HomeRoute(title: 'Dachboden Kasse'),
      ),
    );
  }
}
