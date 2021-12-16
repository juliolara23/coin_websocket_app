import 'package:flutter/material.dart';
import 'package:flutter_websocket_app/service/coinbase_service.dart';
import 'package:flutter_websocket_app/model/coinbase_response.dart';
import 'package:get/get.dart';

class CoinValue extends StatefulWidget {
  const CoinValue({Key? key}) : super(key: key);

  @override
  State<CoinValue> createState() => _CoinValueState();
}

class _CoinValueState extends State<CoinValue> {
  CoinbaseService provider = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Observando :",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: const BorderSide(
                  color: Colors.blueAccent,
                  width: 2.0,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CoinPrice(
                    color: Colors.blue,
                    stream: provider.ethStream,
                  ),
                  CoinPrice(
                    color: Colors.orange,
                    stream: provider.bitcoinStream,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CoinPrice extends StatelessWidget {
  final Stream<CoinbaseResponse> stream;
  final Color color;

  const CoinPrice({
    required this.stream,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: StreamBuilder<CoinbaseResponse>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.hasData) {
            return Center(
              child: Text(
                '${snapshot.data!.productId}: ${snapshot.data!.price}',
                style: TextStyle(
                  color: color,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return const Center(
              child: Text('No more data'),
            );
          }

          return const Center(
            child: Text('No data'),
          );
        },
      ),
    );
  }
}
