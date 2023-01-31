
#### SAP net weaver 란? 
    SAP 모든 프로그램의 프레임 워크라고 할 수 있다.
    현재는 HA/NA라고도 일컬어짐

##### SAP Application Server 는 abap 서버와 java 서버로 나눠짐

## 정의
    APS = APPLICICATION SERVER;
    SAP ECC :SAP ERP Central Componenet;
    CBU = Customer Build Up ;



## B1.p4
    standard SAP 에서 제공해주는 기본 사양
    CUSTOMER dVELOPMENT에서 ABAP DEV가 직접 생성한것을 cbu라고 말함

## B1.p8
    현재는 sap hana db를 기반으로 진행함
    그 이전버전의 아밥서버를 sap ecc라고 말함

    ENTERPRISE PORTAL 웹브라우저 등을 통해 접속 가능
    JAVA 환경으로 제작된 서버 환경임.
    이 서버는 자바로 개발해야함

## B1.P9
    3-tier 시스템을 SAP 에서는 3-RAYER = 3R 로 말함 (REALTIME 3 TIER)
    현재는 hana DB를 많이 사용하는 추세 이전에는 Oracle 사용

## B1.P11
    넷위버의 런타임 환경은 아밥서버와 자바서버로 나눠짐
    이번 교육과정에서는 ABAP 서버만 교육함

## B1.P12
    ABAP 서버는 전형적인 클라이언트 서버 관계로 이루어짐
    프로세스를 요청하고 제공하는 관게로 나눠진 소프트웨어 관점의 서버 구분개념도 존재

## B1.P13
    
    과거 2-TIER 시스템은 DB와 APS를 같은 하드웨어에 적용

    3-TIER 시스템은 전형적인 3T 환경과 동일함
    MULTI-TIER 시스템은 PRESENTATION PROCESS - 웹브라우저 SERVER - APS - DB
    위와같이 여러 계층으로 구성 구성도 가능함(다중 접속자 예상시에)

    SAP SYSTEM은 3-TIRER 를 기본으로 깔고감

## B1.P15
    SAP 서비스단위를 SAP INSTANCE 라고 말함
    SYSTEM ID 와 INSTANCE 번호로 구분함.

    SAP GUI 홀은 웹 브라우저로 SAP APS에서 접속하는데 여러 APS를 각각 다른 INSTANCE를 설치하여 분할 접속할 수 있도록 함
    메신저 서버를 통해 각 APS를 연결함
    DB는 한개 HARDWARE로만 구성됨(?)

## B1.P36

## 질문사항 ?
1. SAP DB는 1개 하드웨어로 구성됨? 분산 DB는 설정할 수 없나? --아닌듯하다.