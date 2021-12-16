import 'package:flutter/material.dart';
import 'package:flutter_websocket_app/pages/coin_buttons.dart';
import 'package:flutter_websocket_app/pages/coin_value.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(
        0.9,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Expanded(
                child: CoinValue(),
                flex: 4,
              ),
              Expanded(
                flex: 2,
                child: CoinButtons(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
