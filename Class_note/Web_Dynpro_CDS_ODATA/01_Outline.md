# WebDynpro

## CDS 뷰
HA/NA DB 는 기본적으로 인 메몰 방식으로 구동 , 서버 종료 및 실행 시 데이터를 가져오기 위해 하드가 존재할 수 도 있따.

DB 처리 속도가 빨라지다 보니 API 서버에서 실행하던 연산을 DB에서 연산처리하는 것으로 내리는 것으로 컨셉이 변경됨.


- Core Data Service : CDS; DB 뷰 프로그램
    - DB에서 연산 처리를 위해 만들어진 뷰 프로그램
    - 실무에서 주로 사용함

## GWS
Gate Way Service : 
SAP/UI5 : 웹 엡 어플리케이션을 제작하기 위해 사용

클라우드 환경에서 DB 접속

Open DATA 라는 프로토콜 규약을 사용함 (MS에서 제작한 Open source)