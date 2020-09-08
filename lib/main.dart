import 'package:flutter/material.dart';

import 'games/color.dart';
import 'games/rockps.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Games',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/color': (context) => ColorGame(),
        '/rockps': (context) => RockPaperScissorsGame(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mini Games')),
      body: GridView.custom(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        childrenDelegate: SliverChildListDelegate(
          [
            Card(
              color: Colors.yellow,
              child: InkWell(
                onTap: () => Navigator.of(context).pushNamed('/color'),
                child: Center(
                  child: Text('Color Game'),
                ),
              ),
            ),
            Card(
              color: Colors.red,
              child: InkWell(
                onTap: () => Navigator.of(context).pushNamed('/rockps'),
                child: Center(
                  child: Text(
                    'Rock-Paper-Scissors\nGame',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
