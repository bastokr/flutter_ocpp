# flutter_ocpp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


안녕하세요
아이마켓코리아 EV개발파트 진미연입니다.

방화벽 등록 신청이 완료되어 회신드립니다.
접속하실 개벌서버 정보는 아래와 같으며, ws 접속 테스트 가능합니다.
실제 충전기의 경우는 SSLVPN 통해서 ws 접속 하거나, TLS 1.2 이상 적용 wss 접속 필요함을 참고 바랍니다.
문의사항 있으시면 회신요청드립니다.
감사합니다.


[개발서버 접속정보]
- 주소 :  ws://112.106.138.100:8151/cp/{충전기ID}
- 접속하실 충전기 ID : IMK00039801, IMK00039802

이상.


방화벽 : 125.176.147.175  ip 추가 필요 

웹에서 호출하는 예제 입니다.

아래는 자바스크립트로 짠 예제입니다.
```c
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WebSocket Example</title>
</head>
<body>
    <script>
        const socket = new WebSocket("ws://112.106.138.100:8151/cp/IMK00039801");

        socket.onopen = function(event) {
            console.log("WebSocket connection established.");
        };

        socket.onmessage = function(event) {
            console.log("Message received:", event.data);
        };

        socket.onclose = function(event) {
            console.log("WebSocket connection closed.");
        };

        function sendWebSocketRequest() {
            // ChargePointId와 AuthorizationKey 설정
            const chargePointId = "IMK00039801";
            const authorizationKey = "<AuthorizationKey>"; ==> 여기에 들어갈 키값 

            // 인증 헤더 생성
            const credentials = chargePointId + ':' + authorizationKey;
            const encodedCredentials = btoa(credentials);

            const requestHeaders = {
                "Upgrade": "websocket",
                "Connection": "Upgrade",
                "Sec-WebSocket-Key": "Pb4obWo2214EfaPQuazMjA==",
                "Sec-WebSocket-Version": "13",
                "Authorization": "Basic " + encodedCredentials
            };

            // Convert headers object into string
            const headersString = Object.keys(requestHeaders)
                .map(key => `${key}: ${requestHeaders[key]}`)
                .join('\r\n');

            // Send WebSocket request
            socket.send(headersString);
        }
    </script>

    <button onclick="sendWebSocketRequest()">Send WebSocket Request</button>
</body>
</html>
```

