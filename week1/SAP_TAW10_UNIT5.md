# sap system core#

## 정의
    WP = Work Process  
    MS = Massage Server : 어플리케이션 서버에 존재하는 디스패쳐를 연결하는 서버  
    GW = GateWay : 시스템간의 연결을 담당함   
    ICM = Internet communication management : 웹 브라우저를 통한 접속시 HTML 해석 프로그램  

## T-code
1. sm50 : 시스템에서 사용하는 WP 확인하는 네비게이터


## B1p.86

시스템 구성요소는 BC가 중요하게 관심가져야할 사항

현재 7.51버전이 주로사용됨.

### 7.0이하버전에서는 아밥 메시지서버를 이용해서 각각 어플리케이션 서버에 존재하는 디스패쳐를 연결함.

    Gate Way :
        ex) erp 시스템과 crm 시스템을 연결할때 GW를 사용함
        즉 시스템간 연결 방식임.
    웹 브라우저를 통한 접속시에는 ICM을 이용해서 접속함


### 7.1이상 버전

    이전버전의 CI가 pas와 cs로 나눠짐 

    메시지서버와 eq서비스가 CS로 내려오게됨.

## B1.p89~90
    아키텍쳐 구성이 다이어그램으로 보여지니까 꼭 확인해보자

## B1.p97
    유저의 모든 리퀘스트는 5개의 워크 프로세스에 의해 이루어짐
    시스템간 최소 2개이상의 WP로 이루어짐


### D dialog wp 
        시스템상 최소 2개이상
        기본적인 시행 워크프로세스

### B background wp 시스템상 최소 1개 이상
        어떠한 스케쥴에 의해서 프로그램을 실행시키는 작업
        어떠한 프로글매엥 의해 다이얼로그 WP가 오래 실행될때 백그라운드WP가 실행됨. 

### V update wp 시스템상 최소 1개 이상
        데이터 업데이트시 사용되는 프로그램

### E Locdk managemetn wp 시스템 상 1개만 존재
        테이블 엑세스 접근 설정 트랜잭션 오류 방지 프로세스

### S spool wp 시스템상 최소 1개 이상
        리포트 등을 출력(Printing?)할떄 사용되는 프로세스


## B1.p104 유저 요청 진행 체계

    SAP GUI - Request queue 를통해 CLI의 요청을 Queue 구조로 저장
    Request를 디스패처가 워크프로세스로 이동

    Screen Processor 스크린 프로세서
        프론트엔드 언어 해석이라고 이해하면 될것
    ABAP Interpretor 아밥 프로세서
        아밥 소스코드 인터프리팅을 담당
    Database Interface 데이터베이스 인터페이스

        DB 인터페이스에서 ABAP 언어라고 할 수 있는 OPEN sql을 스탠다드 sql로 변환해줌
        OPEN SQL 이용 DB접근 standard sql도 사용 가능함.
        local buffer 를 사용하면 캐쉬메모리와같이 빠른 데이터 접근이 가능해짐
        옵셔널한 접근이기 때문에 개발시 퍼포먼스를 위해 염두해둘것.
        Native sql을 사용하기 위해서는 
```abap
        EXEC sql.
            select ~~~
        EXEC end.
```
    이때에는 DB인터페이스에 접근하지 않기 때문에 Local buffer를 사용할 수 없음   
    따라서 속도면에서 효율이 떨어짐.

## B1.P108 다이얼로그 리퀘스트 워크프로세스
    screen 100와 105 를 사용하는 워크프로세스일때의 약도
    디스패쳐가 놀고있는 워크프로세스에다가 일시키는 것을 간단하게 보여주는 그림임.

# 질문
    게이트 웨이는 네트워크 라우터로 생각하면 되나?-