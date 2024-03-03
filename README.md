 


[개발서버 접속정보]
- 주소 :   
- 접속하실 충전기 ID :  

이상.

 
**   방화벽 :    ip 추가 필요  **

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
        const socket = new WebSocket("******************************");

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
            const chargePointId = "************";
            const authorizationKey = "<AuthorizationKey>"; ==> 여기에 들어갈 키값 

            // 인증 헤더 생성
            const credentials = chargePointId + ':' + authorizationKey;
            const encodedCredentials = btoa(credentials);

            const requestHeaders = {
                "Upgrade": "websocket",
                "Connection": "Upgrade",
                "Sec-WebSocket-Key": "**********==",
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

