# CDS
**BOOK** S4D430

1. 아밥 워크벤치(SAP GUI)에서 생성할 수 없음
2. ABAP DEVELOPMENT TOOL을 이용해서 DB로 업데이트 시켜야함.
3. CDS에서는 꼭 NEW Open SQL을 사용해야함

## ABAP의 SQL 접근
### DML 부분
1. 표준 SQL-92 을 기반한 Open SQL 을 사용함
2. DB 독립적인 문법, 행동
3. 제한적인 기능만 사용 가능함
### DDL 부분
1. ABAP DiCC에서 모두 처리함
2. 일정한 양식을 사용해 정의함
### DCL 부분
DB단에 권한은 존재하지 않지만,
어플리케이션 단계에서 처리함

## New Open SQL의 추가부분

## ABAP DICC
P.6.~7. 참고
## S4HANA의 DB 접근방식
S4HANA의 경우 Column Base STorage 개념이다
컬럼이 중복되면 중복사항은 제외하고 저장됨

OLTP & OLAP 실시간 가능함.

DATA 압축이 가능함

## 변경된 ABAP의 컨셉
HANA DB로 변경되면서 DB의 속도가 매우 빨라짐
그래서 기존의 DB 속도한계로 인해 어플리케이션 서버에서 부담하던 연산을 DB로 옮김
이를 Code-to-Data라고 함
P.8. 참고

## S4 HANA의 Core Data Service
    아래 3가지로 구분함
1. DDL : CDS 뷰를
2. QL  : DDL에 의해서 생성된 뷰를 관리할 때 사용
3. DCL : CDS에 대해 권한 부여 프로그램의 권한 컨셉을 사용하거나 DB에서 권한을 설정하여 제어할 수 있음.


abap 서버 7.4 / SP05 이후 모든 DBMS에서 사용할 수 있음.
기술적 속성과 의미적 속성 모두 설정 할 수 있음.

테이블간 조인 및 View-on-View가 가능함
이는 ASSOCIATION으로 활용가능함


## CDS의 구분

아밥 CDS는 뷰를 생성하는 것에 초점을 맞춰놓고
아밥 딕셔너리에서 인터그레이션 한다

하나 CDS는 HANA에서만 가능하고
모델링을 하는 것에 초점을 맞추고 있다

## CDS 또한 아밥 레포지토리 오브젝트로 관리됨

데이터 정의는 : DDL SOURCE

데이터 관리는 : 엑세스 컨트롤 DCL 소스

메타 데이터 확장 : DDLX 소스

ADT에서 데이터 생성하고 수정 삭제할 수있음.

SAP GUI에서는 모두 디스플레이만 가능하고 수정은 ADT에서만 가능하다.

# ADT (ABAP Dev. Tool)

이클립스에 ABAP 퍼스펙티브를 적용해야함

프로젝트를 생성하여 이 프로젝트를 이용해서 아밥 서버에 접속할 수 있음.


## 이클립스 사용
스탠다드 패키지 :  DEVS4D430_DEMO

신규 패키지 : Z4D430_E01

CTRL +6 으로 SAP gui 화면 띄우기 및 티코드 입력도 가능함.

## CDS 뷰의 생성
- DDL Source

가장 먼저 DDL 소스를 이용해서
SQL 뷰와 cDS 뷰 엔터티가 생성된다.
1. SQL View
    SQL 뷰는 아밥 딕셔너리 오브젝트가 되고,
    실제로 DB에 생성된다.
    - 클라이언트 필드를 가지고있다.
    레포지토리 오브젝트로 활용이 가능하다.

2. CDS View Entity
    반면 CDS 뷰 엔터티는 의미상으로 존재하지,
    DB 서버나 아밥 딕셔너리에 존재하지 않는다.
    - 어디셔널 시멘틱을 가질 수 있다.
    - 클라이언트 필드를 가지고 있지않다 (MANDT) 
```abap
    @AbapCatalog.sqlViewName: 'S4D430_CARR'
    @AbapCatalog.compiler.compareFilter: true
    @AccessControl.authorizationCheck: #CHECK
    @EndUserText.label: 'Demo: Simple Projection'
    define view S4d430_Carrier as 
        select carrid, 
               carrname, 
               @Semantics.currencyCode: true
               currcode, 
               url 
          from scarr  
```
## Annotations P.28.
- 기본적으로 선택 조건이지만
    @AbapCatalog.sqlViewName 
    SQLVIEWNAME 만 필수 적으로 선언해야한다.

뷰 선언 이전에도 올수 있고 셀렉문 필드 뒤나 앞에 올 수 가 있다.
- 필드 앞에올때는 @만 오면되고
- 플드 뒤에 올 댸에는 <가 있어야한다.
예시
```abap
    @AbapCatalog.sqlViewName : 'S4D430_CARR'.
    define view S4d430_Carrier as select carrid,
                                         carname.
                                         @EndUserText.label : 'Currency Code'
                                         curcode,
                                         url @<EndUserText.label : 'Homepage'
                                from scarr
```

### 쇼 SQL 스테이트먼트
DDL 소스에서 우측 클릭해서 
프로그램 : S4D430_CARRIER


### Dependency Analyzer
프로그램 : S4D430_BOOKING_AND_AGENCY
### DATA Preview
F8 혹은 Open With 데이터 프리뷰를 통해 실행

## 7.50 이상 버전 신규 문법
INTO 적이 제일 마지막에 올 수 있고 
FIELDS 를 통해 선택 필드를 결정할 수 있음
예시
```SQL
    SELECT 
        FROM SFLIGHT
        FIELDS CARRID , CONNID, FLDATE, SUM( PATMENTSUM ) ,CURRECCY
        WHERE FLDATE > @SY-DATUM
        GROUP BY CARRID, CONNID, FLDATE, CURRECCY
        ORDER BY CARRID, CONNID
        INTO TABLE @GT_FLIGHTS.
```

## CDS VIEW 생성 실습
ADT를 통해 DATA Definition을 통해 생성

ADT 에서는 기본적인 템플릿을 제공하고 있음.

### 문법상 제한사항
- ASCII 코드만 사용가능
- **모두 소문자** 혹은 **모두 대문자** 혹은 첫글자만 대문자 나머지는 소문자로만 사용가능
- 소수는 항상 0.X로 입력해야함.
- 문자열은 ''로 감싸면된다.
- 다중열 주석처리는 /* */로 적용
- 라인 주석은 //
- 문장 끝은 ;

### 문법
Define View [뷰 이름] as
        select

### 프로그램 네이밍 제한사항
1. DDL SOURCE NAME
    - 최대 30자리
    - 서버상 유니크한 이름
    - 항상 대문자

2. CDS View Name
    - 최대 30자
    - 서버상 유니크한 이름
    - 대소문자 구분 X
    - DDL 소스 이름과 똑같이해야한다.
3. SQL View NAME
    - 최대 16자
    - 서버상 유니크한 이름
    - 아밥에서 전역변수로 사용가능함.
    - 대문자로 생성
    - **CDS 뷰와 이름을 다르게 생성해야한다.**

### 실습 사항
DDL 이름 : zddl_connect_e01
선택한 템플릿 : Define view
- 템플릿 내용
```abap
    @AbapCatalog.sqlViewName: ''
    @AbapCatalog.compiler.compareFilter: true
    @AbapCatalog.preserveKey: true
    @AccessControl.authorizationCheck: #NOT_REQUIRED
    @EndUserText.label: 'Connection My First CDS View'
    define view zddl_connect_e01 as select from data_source_name {

    }
```

1. sqlViewName이 먼저설정해야함
2. data souce name을 선택해야함
    - 테이블 이름 혹은 다른 CDS 뷰 이름이 올 수 있음
3. 중괄호 안에 필드 이름이 오면됨
```abap
    @AbapCatalog.sqlViewName: 'ZV_CONNECT_E01'
    @AbapCatalog.compiler.compareFilter: true
    @AbapCatalog.preserveKey: true
    @AccessControl.authorizationCheck: #NOT_REQUIRED
    @EndUserText.label: 'Connection My First CDS View'
    define view zddl_connect_e01 as select from sflight {
        carrid,
        connid,
        fldate,
        seatsmax,
        seatsocc
    }
```

이 상태로 ACTIVATE 하면 위에 설정한 sqlViewName으로 ABAP DICC에 뷰가 생성됨.

## CDS 뷰 활용 실습
프리티 프린트 : Shift F1
주석 처리 및 복귀 : Ctrl 7

program : zread_cds_e01.

변수 활용과 동시에 선언하는 방법
```abap
    select * into TABLE @data(gt_data)
    from zddl_connect_e01
    where carrid = 'AA'.

   cl_demo_output=>display(  gt_data ).
```

AMDP : 아밥 메니지드 데이터 베이스 프로시져

```abap
    @AbapCatalog.sqlViewName: 'ZE01SIMPLE'
    @AbapCatalog.compiler.compareFilter: true
    @AbapCatalog.preserveKey: true
    @AccessControl.authorizationCheck: #NOT_REQUIRED
    @EndUserText.label: 'Define View Unit 2Exercise 3'
    define view ze01_simple as select from sbook {
            bookid,
            carrid,
            connid,
            class,
            @Semantics.amount.currencyCode: 'forcurkey'
            forcuram,
            @Semantics.currencyCode: true
            forcurkey,
            @Semantics.quantity.unitOfMeasure: 'WUNIT'
            luggweight,
            @Semantics.unitOfMeasure: true
            wunit,
            order_date,
            agencynum,
            counter,
            customid
    }
```

## CDS 뷰 JOIN
CDS 의 정의부에서는 오더 바이를 사용할 수 없다,
### KEY Definition과 Selections

```abap
    define view ddl_name as select
    from spfli as c
    inner join scarr as a
    on c.carrid = a. carrid
    
    {
    key c.carrid,
    key c.connid,
        a.fldate,
        c.seatsmax,
        c.seatsocc
    }
    where c.fltype <> 'X'
```

## ANNOTATION의 분류
P.69. ~~ P.83 ------------------------------------------------------------------------------------------
정리할 것.
CDS 뷰는 INPUT PARAMETER를 가질 수 있다.

스탠다드 CDS 뷰를 인핸스먼트해서 활용할 수 있다.
 : goto-Append View를 실행한다.

|구분|특이사항|예시|
|---|---|---|
|View Annotaion| Define 하기 이전에 선언되어야함|@AbapCatalog.sqlViewName: '' <br>@AbapCatalog.buffering.numberOfKeyFields: 004|
|Element Annotaion|필드 앞 혹은 뒤에 올 수 있음|@Endusertext.label : ''|
|Parameter Annotaion||
|Extension Annotaion||
|Function Annotaion||

### 필수 선언 Annotaion
@AbapCatalog.sqlViewName: '' : SQL 뷰 이름을 꼭 선언해야함

### 선택적 선언 Annotaion
필수 선언 이외에 대부분의 ANNOTATION은 선택 사항이다.

만약 ALlias를 사용했다면 문장 상단에서 해당 필드를 불러오더라도 allias한 이름으로 호출해야한다.

개별 및 그룹 ANNOTATION도 가능하다.

@Endusertext.label : '' ; 최대 60자 까지 가능
@Endusertext.Quickinfo : '' ; 


Tcode = SE63
트랜잭션 에디터 프로그램
라벨 언어를 번역해서 실행할 수 ㅣㅇㅆ음.


Cl_dd_DDL_annotation_service=>Get_label_4_element

CDS 뷰에서 선언된 라벨과 번역된 텍스트를 가져올 수 있는 함수.


### sql Expressions
실습 CDS 뷰 :ZDDL_LITERAL_E01

P.84.
리터럴 기능을 사용한다면
자동으로 데이터 타입을 끌고온다.

### CASE Distinction

실습 CDS 뷰 : zddl_simple_case_e01
**문법**
simple 케이스
```sql
    case operand
        when operand1 then result1
        [when operand2 then result2]
        ...
        [else resultn]
    end

    case smoker when 'X' then cast (loccuram as abap.fltp )* 1.2
                    else cast (loccuram as abap.fltp ) * 0.8
    end as adjust_amt
        @<Semantics.amount.currencyCode: 'loccurkey',
        loccurkey
        @<Semantics.currencyCode: true   
```
복합 케이스
```sql
    case when sql_condition1 then result1
        [when  sql_condition2 then result2]
        ...
        [else resultn]
    end
```
네스티드 케이스
```sql
    case class
        when 'F' then ' '
        else 
            case 
                when ( wunit ='KG' and luggweight > 20)
                  or ( wunit ='LB' and luggweight > 44)
                then 'X'
                else ' '
            end
    end
```

## HANA DB
HANA DB에 엑세스해서 뷰를 생성할 수 있음
비록 OPEN SQL을 사용할 수 없음.

## 연산
기본적인 사칙연산과 괄호를 사용함

## cast
```sql
    cast ( operand as target_type [preserve Type] )
```
프리 디파인드 딕셔너리 타입은 ABAP.int4 와 같이 abap.이 앞으로 오게된다.
만약 의미적 속성만 씌우고 싶으면 preserve Type을 선언하면 된다.

- 예시 
```sql
    define Expressionexam as select from sbook {
        '19891109' as 
    cast( '19891109' as abap.char(4) ) as col_char
    cast( '19891109' as abap.dec(8,2) )  as col_dec
    cast( '19891109' as abap.dats)  as col_dats
    cast( '19891109' as s_date)  as col_date
    cast( '19891109' as s_customer perserving type)  as col_ccust
    cast( seatsocc as abap.fltp) / cast(seatsmax as abap.fltp) as ratio
    }
```

실습 뷰 
ZDDL_CONNECT_E01
ZDDL_INNERJOIN_E01
ZDDL_LITERAL_E01
ZDDL_SIMPLE_CASE_E01
ZE01_ANNOTATIONS
ZE01_JOIN_AND_SELECTION
ZE01_SIMPLE