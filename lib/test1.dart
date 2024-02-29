import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  var headers = {};
  late IOWebSocketChannel channel;

  @override
  void initState() {
    String chargePointId = "<ChargePointId>";
    String authorizationKey = "<AuthorizationKey>";

    String credentials = '$chargePointId:$authorizationKey';
    String encodedCredentials = base64Encode(utf8.encode(credentials));

    print(encodedCredentials); //

    headers = {
      'Remote-Addr': '127.0.0.1',
      'UPGRADE': 'websocket',
      'CONNECTION': 'Upgrade',
      'HOST': '127.0.0.1:9999',
      'ORIGIN': 'http://127.0.0.1:9999',
      'SEC-WEBSOCKET-KEY': 'Pb4obWo2214EfaPQuazMjA==',
      'SEC-WEBSOCKET-VERSION': '13',
      'AUTHORIZATION': 'Basic ${base64Encode(utf8.encode(encodedCredentials))}',
    };

    channel = IOWebSocketChannel.connect(
      'ws://192.168.0.71:9000',
      headers: {'Sec-WebSocket-Protocol': "ocpp1.6"},
    );

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OCPP Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('OCPP Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  bootNotification();
                },
                child: const Text('Start Charging'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void bootNotification() {
    const message =
        '[2,"19223201","BootNotification",{"chargePointVendor": "VendorX","chargePointModel": "SingleSocketCharger"}]';
    channel.sink.add(message.toString());
  }
}
