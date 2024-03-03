import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';

/*
OCPP 프로토콜의 다양한 메시지 유형에 대한 MessageTypeId 값은 OCPP 표준의 버전과 프로필에 따라 다를 수 있습니다. 일반적으로 사용되는 OCPP 1.x 및 2.x 버전에서의 몇 가지 주요 메시지 유형과 해당하는 MessageTypeId 값은 다음과 같습니다:

BootNotification (부팅 알림):
MessageTypeId 값: 2 Heartbeat (하트비트):
MessageTypeId 값: 2 MeterValues (미터 값):
MessageTypeId 값: 4 StatusNotification (상태 알림):
MessageTypeId 값: 2 TransactionEvent (거래 이벤트):
MessageTypeId 값: 2 Authorize (인증):
MessageTypeId 값: 2 StartTransaction (거래 시작):
MessageTypeId 값: 2 StopTransaction (거래 중단):
MessageTypeId 값: 2 DataTransfer (데이터 전송):
MessageTypeId 값: 2 FirmwareStatusNotification (펌웨어 상태 알림):
MessageTypeId 값: 2 DiagnosticsStatusNotification (진단 상태 알림):
MessageTypeId 값: 2 ChangeAvailability (가용성 변경):
MessageTypeId 값: 2 ChangeConfiguration (구성 변경):
MessageTypeId 값: 2 ClearCache (캐시 지우기):
MessageTypeId 값: 2 GetConfiguration (구성 가져오기):
MessageTypeId 값: 2 RemoteStartTransaction (원격 거래 시작):
MessageTypeId 값: 2 RemoteStopTransaction (원격 거래 중단):
MessageTypeId 값: 2 UnlockConnector (커넥터 잠금 해제): 
*/

class Occp16 extends StatelessWidget {
  var uuid = Uuid();
  String newUuid = "";
  int count = 1;
  String ipport = "127.0.0.1:8887";
  late var channel;
  Occp16({super.key});

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
        body: Container(
            // height: 400,
            // width: 800,
            child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              //원격 거래 시작
              //넥터 잠금 해제
              ElevatedButton(
                onPressed: () {
                  connect();
                },
                child: Text('커넥터'),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    bootNotification();
                  },
                  child: Text('bootNotification\n 부팅 알림 '),
                ),

                ElevatedButton(
                  onPressed: () {
                    Heartbeat();
                  },
                  child: Text('Heartbeat\n하트비트'),
                ),
                ElevatedButton(
                  onPressed: () {
                    MeterValues();
                  },
                  child: Text('MeterValues\n미터 값'),
                ), //미터 값
                ElevatedButton(
                  onPressed: () {
                    StatusNotification();
                  },
                  child: Text('StatusNotification\n상태 알림'),
                ), //상태 알림 //하트비트
              ]),
          SizedBox(
            height: 10,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    TransactionEvent();
                  },
                  child: Text('TransactionEvent'),
                ), //거래 이벤트
                ElevatedButton(
                  onPressed: () {
                    Authorize();
                  },
                  child: Text('Authorize\n인증'),
                ), //인증
                ElevatedButton(
                  onPressed: () {
                    StartTransaction();
                  },
                  child: Text('StartTransaction\n거래 시작'),
                ),
                ElevatedButton(
                  onPressed: () {
                    StopTransaction();
                  },
                  child: Text('StopTransaction\n거래 중단'),
                ), //거래 중단 //거래 시작
              ]),
          SizedBox(
            height: 10,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    DataTransfer();
                  },
                  child: Text('DataTransfer\n데이터 전송'),
                ), //데이터 전송
                ElevatedButton(
                  onPressed: () {
                    FirmwareStatusNotification();
                  },
                  child: Text('FirmwareStatusNotification\n 펌웨어 상태 알림'),
                ), //펌웨어 상태 알림
                ElevatedButton(
                  onPressed: () {
                    DiagnosticsStatusNotification();
                  },
                  child: Text('DiagnosticsStatusNotification\n 단 상태 알림'),
                ), //진단 상태 알림
                ElevatedButton(
                  onPressed: () {
                    ChangeAvailability();
                  },
                  child: Text('ChangeAvailability\n 가용성 변경'),
                ), //가용성 변경
              ]),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  ChangeConfiguration();
                },
                child: Text('ChangeConfiguration\n 성 변경'),
              ), //구성 변경
              ElevatedButton(
                onPressed: () {
                  ClearCache();
                },
                child: Text('ClearCache\n 캐시 지우기'),
              ), //캐시 지우기
              ElevatedButton(
                onPressed: () {
                  GetConfiguration();
                },
                child: Text('GetConfiguration\n 구성 가져오기'),
              ), //구성 가져오기
              ElevatedButton(
                onPressed: () {
                  RemoteStartTransaction();
                },
                child: Text('RemoteStartTransaction \n 원격 거래 시작'),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              //원격 거래 시작
              ElevatedButton(
                onPressed: () {
                  RemoteStopTransaction();
                },
                child: Text('RemoteStopTransaction\n 원격 거래 중단'),
              ), //원격 거래 중단
              ElevatedButton(
                onPressed: () {
                  UnlockConnector();
                },
                child: Text('UnlockConnector\n 넥터 잠금 해제'),
              ),
            ],
          ),
        ])),
      ),
    );
  }

  void connect() {
    newUuid = uuid.v4();
    channel = IOWebSocketChannel.connect(
      'ws://127.0.0.1:8887',
      headers: {'Sec-WebSocket-Protocol': "ocpp1.6"},
    );
    channel.stream.listen(
      (message) {
        print('Received message: $message');
        count = count + 1;
        // 이 부분에 메시지를 처리하는 로직을 추가할 수 있습니다.
      },
      onError: (error) {
        print('Error: $error');
        // 이 부분에 오류 처리 로직을 추가할 수 있습니다.
      },
      onDone: () {
        print('Channel closed');
        // 이 부분에 채널이 닫혔을 때 실행할 로직을 추가할 수 있습니다.
      },
    );
  }

  void bootNotification() {
    print("count======>$count");

    final message = [
      2,
      newUuid,
      "BootNotification",
      {
        "chargePointVendor": "VendorX",
        "chargePointModel": "SingleSocketCharger"
      }
    ];
    print(jsonEncode(message));
    channel.sink.add(jsonEncode(message));
  }

  void Heartbeat() {
    final message = [
      2,
      newUuid,
      "Heartbeat",
      {
        "connectorId": 1,
        "status": "Available",
        "currentTime": "2024-03-03T12:30:00Z"
      }
    ];
    channel.sink.add(jsonEncode(message));
  }

  void StatusNotification() {
    final message = [
      2,
      newUuid,
      "StatusNotification",
      {
        "connectorId": 1,
        "status": "Unavailable",
        "errorCode": "ConnectorLockFailure"
      }
    ];
    channel.sink.add(jsonEncode(message));
  }

  void TransactionEvent() {
    final message = [
      2,
      "validUuidString",
      "TransactionEvent",
      {
        "timestamp": "2024-03-03T12:30:00Z",
        "eventType": "Ended",
        "transactionId": 12345,
        "idTag": "tag123",
        "connectorId": 1,
        "meterValue": 100.5
      }
    ];
    channel.sink.add(jsonEncode(message));
  }

  void Authorize() {
    final message = [
      2,
      "validUuidString",
      "Authorize",
      {"idTag": "tag123"}
    ];
    channel.sink.add(jsonEncode(message));
  }

  void StartTransaction() {
    final message = [
      2,
      "validUuidString",
      "StartTransaction",
      {
        "connectorId": 1,
        "idTag": "tag123",
        "meterStart": 0,
        "timestamp": "2024-03-03T12:30:00Z"
      }
    ];
    channel.sink.add(jsonEncode(message));
  }

  void StopTransaction() {
    final message = [
      2,
      "validUuidString",
      "StopTransaction",
      {
        "transactionId": 12345,
        "idTag": "tag123",
        "timestamp": "2024-03-03T13:30:00Z",
        "meterStop": 100.5,
        "reason": "Local"
      }
    ];
    channel.sink.add(jsonEncode(message));
  }

  void DataTransfer() {
    final message = [
      2,
      "validUuidString",
      "DataTransfer",
      {
        "vendorId": "Vendor123",
        "messageId": "Message456",
        "data": "Base64EncodedData"
      }
    ];
    channel.sink.add(jsonEncode(message));
  }

  void FirmwareStatusNotification() {
    final message = [
      2,
      "validUuidString",
      "FirmwareStatusNotification",
      {
        "status": "DownloadFailed",
        "errorCode": "CommunicationError",
        "info": "Firmware download failed due to communication error."
      }
    ];
    channel.sink.add(jsonEncode(message));
  }

  void DiagnosticsStatusNotification() {
    final message = [
      2,
      "validUuidString",
      "DiagnosticsStatusNotification",
      {
        "status": "Uploaded",
        "errorCode": "NoError",
        "info": "Diagnostics data has been successfully uploaded."
      }
    ];
    channel.sink.add(jsonEncode(message));
  }

  void ChangeAvailability() {
    final message = [
      2,
      "validUuidString",
      "ChangeAvailability",
      {"connectorId": 1, "type": "Operative"}
    ];
    channel.sink.add(jsonEncode(message));
  }

  void ChangeConfiguration() {
    final message = [
      2,
      "validUuidString",
      "ChangeConfiguration",
      {"key": "MaxCurrent", "value": "20"}
    ];
    channel.sink.add(jsonEncode(message));
  }

  void ClearCache() {
    final message = [2, "validUuidString", "ClearCache", {}];
    channel.sink.add(jsonEncode(message));
  }

  void GetConfiguration() {
    final message = [
      2,
      "validUuidString",
      "GetConfiguration",
      {
        "key": ["MaxCurrent", "MinCurrent"]
      }
    ];
    channel.sink.add(jsonEncode(message));
  }

  void MeterValues() {
    final message = [
      2,
      "validUuidString",
      "MeterValues",
      {
        "connectorId": 1,
        "transactionId": 12345,
        "meterValue": [
          {"timestamp": "2024-03-03T12:30:00Z", "value": "100.5", "unit": "Wh"},
          {"timestamp": "2024-03-03T12:40:00Z", "value": "110.7", "unit": "Wh"}
        ]
      }
    ];
    channel.sink.add(jsonEncode(message));
  }

  void RemoteStartTransaction() {
    final message = [
      2,
      "validUuidString",
      "RemoteStartTransaction",
      {
        "connectorId": 1,
        "idTag": "tag123",
        "chargingProfile": {
          "chargingProfileId": 123,
          "chargingProfilePurpose": "TxProfile",
          "chargingProfileKind": "Absolute",
          "recurrencyKind": "Weekly",
          "chargingSchedule": [
            {
              "startPeriod": 0,
              "chargingRateUnit": "A",
              "chargingSchedulePeriod": [
                {"startPeriod": 0, "limit": 16},
                {"startPeriod": 720, "limit": 8}
              ]
            }
          ]
        }
      }
    ];
    channel.sink.add(jsonEncode(message));
  }

  void RemoteStopTransaction() {
    final message = [
      2,
      "validUuidString",
      "RemoteStopTransaction",
      {"transactionId": 12345}
    ];
    channel.sink.add(jsonEncode(message));
  }

  void UnlockConnector() {
    final message = [
      2,
      "validUuidString",
      "UnlockConnector",
      {"connectorId": 1}
    ];
    channel.sink.add(jsonEncode(message));
  }

/*

OCPP 프로토콜의 다양한 메시지 유형에 대한 MessageTypeId 값은 OCPP 표준의 버전과 프로필에 따라 다를 수 있습니다. 일반적으로 사용되는 OCPP 1.x 및 2.x 버전에서의 몇 가지 주요 메시지 유형과 해당하는 MessageTypeId 값은 다음과 같습니다:

BootNotification (부팅 알림):

MessageTypeId 값: 2
Heartbeat (하트비트):

MessageTypeId 값: 2
MeterValues (미터 값):

MessageTypeId 값: 4
StatusNotification (상태 알림):

MessageTypeId 값: 2
TransactionEvent (거래 이벤트):

MessageTypeId 값: 2
Authorize (인증):

MessageTypeId 값: 2
StartTransaction (거래 시작):

MessageTypeId 값: 2
StopTransaction (거래 중단):

MessageTypeId 값: 2
DataTransfer (데이터 전송):

MessageTypeId 값: 2
FirmwareStatusNotification (펌웨어 상태 알림):

MessageTypeId 값: 2
DiagnosticsStatusNotification (진단 상태 알림):

MessageTypeId 값: 2
ChangeAvailability (가용성 변경):

MessageTypeId 값: 2
ChangeConfiguration (구성 변경):

MessageTypeId 값: 2
ClearCache (캐시 지우기):

MessageTypeId 값: 2
GetConfiguration (구성 가져오기):

MessageTypeId 값: 2
RemoteStartTransaction (원격 거래 시작):

MessageTypeId 값: 2
RemoteStopTransaction (원격 거래 중단):

MessageTypeId 값: 2
UnlockConnector (커넥터 잠금 해제):

MessageTypeId 값: 2
*/
}
