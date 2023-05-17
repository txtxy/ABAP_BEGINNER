# Open data Service

https://gocoding.org/ko/%EC%88%98%EC%95%A1-odata%EB%A5%BC-%EB%A7%8C%EB%93%9C%EB%8A%94-%EB%B0%A9%EB%B2%95/
참고 자료

http 규약을 사용한 오픈 데이터 서비스
UI5에 대한 BACKEND 작업을 위해 사용함

다른 데이터 전송 방법 : RFC

관련 TCODE 
SEGW                 : 게이트웨이 서비스 빌더
/iwfnd/maint_service : ODATA 프론트엔드 서버 테스트 
/IWFND/ERROR_LOG     : 에러로그 확인

UNIT 3부터 교육 시작

P.95
## 기본 개념
 SAP GUI 외부에서 SAP 서버 내부의 데이터를 이용하고자 할때 
 HTTP 규약을 이요하여 DATA 교환을 하기 위해 MS의 OPEND DATA SERVICE 통신규약을 활요함

 백엔드를 위해 Gate Way를 설치하여 필요정보를 교환


## 게이트 웨이 서비스 설치

SEGW - GATEWAY SERVICE BUILDER

1. 프로젝트를 생성 (SEGW)
    - 마찬가지로 프로젝트 이름은 Z또는 Y로 시작되어야 함

2. 데이터 모델을 정의
    - 프로젝트 폴더 내부에 엔터티와 관계등을 설정하는 것
    - 방법은 크게 4가지로 구분 할 수 있음 
        1. ABAP DICC의 스트럭쳐를 이용해서 IMPORT하는 방법
        2. 혹은 RFC 혹은 BOR 인터페이스를 이용하는 방법
        3. 데이터 모델링 파일을 추가하는 방법
        4. 매뉴얼로 모델 컴포넌트를 생성하는 방법

3. 서비스 구현
    모델을 정의하고 런타임 오브젝트 생성을 실행하면 6개의 클래스가 생성됨
    1. DPC; data provide class
    2. DPC_Ext
    3. MPC
    4. MPC_EXT
    5. MDL
    6. SRV

--- **외부** ---

4. 게이트웨이 서버(HUB)에서 해당 서비스를 사용할 수 있게끔 등록해야한다.


### 기본적인 CRUD METHOD
GET POST 등 프로토콜 규약 동일

1. CREATE -> <Entity_Set>_Create_ENTITY
2. Read -> <Entity_Set>_Get_ENTITY
3. Query -> <Entity_Set>Get_ENTITY_set
4. Update -> <Entity_Set>_Update_ENTITY
5. Delete ->  <Entity_Set>_Delete_ENTITY

위의 메소드들은 SEGW 내부 Service Implemantation에서 확인가능함

### BOR 혹은 RFC, Search Help를 이용할 경우
DATA MAPPING을 이용함.

## Query 실습
unit3 Exercise 7

SEGW에서 신규 프로젝트 생성

데이터 모델에 SCARR 스트럭쳐를 딕셔너리에서 Import

이후 런타임 메소드 생성기를 작동시키면
서비스 임플리먼트에 5개의 기본 메쏘드가 생겨난 것을 확인하 수 있음

설치하고자 하는 Method의 클래스 빌더로 이동해서 해당 Method 내용 작성

해당 메쏘드에 시그니처중 ET_ECTITYSET이 테이블 변수로 Export됨

이후 SEGW로 돌아와서 프론트 엔드 서버로 등록함.

## READ 실습

unit3 Exercise 8

SEGW에서 프로젝트 생성
데이터 모델에 SCARR 스트럭쳐를 딕셔너리에서 Import

런타임 메소드 생성기를 작동
서비스 임플리먼트에 5개의 기본 메쏘드가 생겨난 것을 확인하 수 있음

 프론트 엔드 서버를 Service Maintain에서 REGISTRY 할 수 있다.

 등록한 뒤에 ICF Node가 활성화 되었는 지 꼭 확인해야한다.



## 데이터 모델 정의
P.119.


생성 하고 나서 MPC  클래스에 보면 데이터 모델에 대한 내용이 모두 보인다.

그리고 각각의 속성을 프로퍼티라고 지칭함

메쏘드 브레이크 포인트 설정을 위해서는 External Breake-point로 설정해야한다.


/sap/opu/odata/SAP/ZGW100_E01_STUDENT_SRV/PRODUCTSet('AR-FB-1000')/Name/$value

## 엔터티간의 관계설정

어쏘시에이션(관계) 생성

주 엔터티와 보조엔터티 선택
관계차수 선택
주 엔터티에서 보조엔터티로의 네비게이션 설정
PK 설정
엔터티 이름 설정 확인하고 
제너레이트 런타임 오브젝트 실행


## Filtering 처리

원하는 메쏘드 클래스 빌더로 이동

필터링할 변수 등을 선언하여 사용
```abap
        DATA : lt_filter TYPE /iwbep/t_mgw_select_option,
               ls_filter like LINE OF lt_filter,
               rt_cityfr TYPE RANGE OF zcl_zgw_flight_e01_mpc=>ts_connection.

        lv_source = io_tech_request_context->get_source_entity_set_name( ).

        lt_filter = io_tech_request_context->get_filter( )->get_filter_select_options( ).

    READ TABLE lt_filter into ls_filter WITH TABLE KEY property = 'CITYFROM'.
    IF  sy-subrc = 0.
      MOVE-CORRESPONDING ls_filter-select_options to rt_cityfr.
ENDIF.


```

## CREATE

페이지 185

PUT 은 값이 없는 키는 NULL 값을 가진다.

PATCH와 MERGE는 값이 없는 키는 가지고 있는 값으로 유지????


스탠다드 테이블은 BAPI나 등등으로 처리한다.