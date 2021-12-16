import 'package:flutter/material.dart';
import 'package:flutter_websocket_app/service/coinbase_service.dart';
import 'package:get/get.dart';

class CoinButtons extends StatefulWidget {
  const CoinButtons({Key? key}) : super(key: key);

  @override
  _CoinButtonsState createState() => _CoinButtonsState();
}

class _CoinButtonsState extends State<CoinButtons> {
  bool _showBitcoin = false;

  bool _showEthereum = false;

  CoinbaseService provider = Get.find();

  @override
  void reassemble() {
    super.reassemble();
    provider.closeBitcoin();
    provider.closeEthereum();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          if (!_showBitcoin || !_showEthereum)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CoinButton(
                    isSocketOpen: _showEthereum,
                    title: "ETH",
                    backgroundColor: Colors.blue,
                    onTap: (isSocketOpen) {
                      if (!isSocketOpen) {
                        provider.openEthereum();
                        setState(() => _showEthereum = true);
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 24.0,
                ),
                Expanded(
                  child: CoinButton(
                    isSocketOpen: _showBitcoin,
                    title: "BTC",
                    backgroundColor: Colors.orange,
                    onTap: (isSocketOpen) {
                      if (!isSocketOpen) {
                        provider.openBitcoin();
                        setState(() => _showBitcoin = true);
                      }
                    },
                  ),
                ),
              ],
            ),
          if (_showBitcoin && _showEthereum)
            MaterialButton(
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(
                    Icons.warning,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    "CLOSE SOCKETS",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              onPressed: () {
                provider.closeBitcoin();
                provider.closeEthereum();
              },
            )
        ],
      ),
    );
  }
}

class CoinButton extends StatelessWidget {
  final bool isSocketOpen;
  final String title;
  final Function(bool) onTap;
  final Color backgroundColor;

  const CoinButton({
    required this.isSocketOpen,
    required this.title,
    required this.onTap,
    required this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => !isSocketOpen ? onTap(isSocketOpen) : null,
      color: backgroundColor,
      child: Row(
        children: [
          if (!isSocketOpen)
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
          if (isSocketOpen)
            const Icon(
              Icons.check,
              color: Colors.green,
            ),
          Text(title),
        ],
      ),
    );
  }
}
