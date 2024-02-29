import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final channel = IOWebSocketChannel.connect(
    'ws://192.168.0.71:9000',
    headers: {'Sec-WebSocket-Protocol': "ocpp1.6"},
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OCPP Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('OCPP Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  bootNotification();
                },
                child: Text('Start Charging'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void bootNotification() {
    final message =
        '[2,"19223201","BootNotification",{"chargePointVendor": "VendorX","chargePointModel": "SingleSocketCharger"}]';
    channel.sink.add(message.toString());
  }
}
