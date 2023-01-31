# ABAP OpenSQL

## Aggregating Dataset

### ODER BY
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Internal Table에서 <b>SORT</b>하는게 훨씬 이득임.
- PK order by
    - select *일 경우  
    order by Primary key.  
    PK값의 ASC가 디폴트로 조회

    - SELECT 특정컬럼  
    order by Primary key.를 하기 위해서는  
     MANDT를 포함한 모든 PK컬럼이 조회조건에 추가되야함.

- 일반컬럼 Oder by   
    정렬하고자 하는 모든 컬럼이 조회조건에 포함되어야함.  
    다중 정렬시 "," 미사용.  

---

### DISTINCT
    SQL과 동일함.
    집계함수간 연계안됨.<b>B2.P631</b>참조

---

### AGGREGATION Function (집계 합수)
<b>B2.p628</b>  

|함수|기능|데이터형식|
|:---:|:---:|---|
|MIN()|최소값| LIKE COLUMN|
|MAX()|최대값| LIKE COLUMN|
|SUM()|합계| LIKE COLUMN|
|AVG()|평균| FLOAT TYPE|
|COUNT()|개수| INTERGER TYPE|

- COUNT()의 경우  
   조회하는 컬럼에 Distinct를 사용할 수 있다.  
    즉 유일한 값의 집계값을 알 수 있다.

### 특수 CASE
<b>B2.P631</b>

1. Aggregate Functions only    
    집계함수를 이용하면 조회할 데이터가 없으면  
    0값을 RETURN함 따라서,  
    SY-subrc는 정상값이고 sy-dbcnt는 1개로 받게됨.

2. Only aggregate function count(\*)  
    <b>count(\*)만할때는 into절은 생략가능함.</b>  
    테이블에 데이터가 존재하는 지 확인할때 사용가능한 기능임.    
    합계값 1개만 얻을때는 Data Elements에 INTO할 수 있다.

### GROUP BY절
    SQL과 동일함.  
    다중 GROUP시 ","을 사용하지 않음.  
    Grouping 할 컬럼이 조회 컬럼에 꼭 포함되어있어야한다.
### HAVING절
    SQL과 동일함.

---  

## Where condition and Special INTO condition
SQL과 동일

1. <b>LIKE </b>  
    SQL과 동일함. 
    - % : 개수 상관없는 검색; `LIKE '%8'` => 자리수 상관없이 끝이 8인 모든 것
    - _ : 한칸만 검색 ; `LIKE '___8'` => 끝자리가 8인것 5자리 검색
2. <b>IN seltab</b>  
    SELECT-OPTIONS   
   &nbsp;&nbsp;&nbsp;&nbsp;즉, 선택 옵션에 부합하는 조건만 조회할 수 있음.
3. <b>IS [NOT] NULL</b>  
    SQL과 동일
4. <b>AND, OR, NOT</b>  
    SQL과 동일
5. <b>IN(a,b,c)</b>  
    SQL과 동일
6. <b>BETWEEN A AND B</b>  
    SQL과 동일

---
### Table Field Comparison

<b>B2.P643</b>
- 출발국가와 도착국가가 동일한 것
```abap
    DATA gt_spfli TYPE TABLE OF spfli.

    SELECT * FROM spfli
             INTO TABLE gt_flight
             WHERE countryfr = spfli~countryto
    .
```

- 내부 조인 비슷한 활용
```abap
    DATA gt_spfli TYPE TABLE OF spfli.

    SELECT * FROM spfli as a
             INTO TABLE gt_flight
             WHERE seatsocc_b = a~seatmax_b and
             seatsocc < a~seatmax
    .
```
---
### INTO 절의 데이터 타입
- INTO 절은 SELECT 조회 조건의 순서대로 입력이 된다.
- 이름을 통한 매칭이 기본이 아니다.

|Statement|Result-Set|Target Area|
|:---|:---:|:---:|
|SELECT SINGLE |SINGLE|SINGLE-LINE|
|SELECT ... INTO TABLE|MULTI-LINE|MULTI-LINE|
|SELECT ... ENDSELCET|MULTI-LINE|SINGLE-LINE|

---
#### SINGLE-LINE 
<B>B2.P644</B>

---
#### MULTI-LINE

INTO 절을 APPEND절로 변경해서 조회할 수 있음  
INTO절은 기존 조회 데이터를 전부 삭제하고 덮어쓰기  
APPEND절은 말그대로 데이터를 추가함.

- 몇개 컬럼만 추가할떄도 전체 데이터가 삭제되는가?
- 각기 다른 컬럼을 반복적으로 어펜드한다면 데이터 레코드가 추가되는지?
아니면 알맞은 로우에 업데이트 되는지?

---
#### Package Size

    N건의 데이터를 반복 처리
```abap
    select * from sbook into table gt_book
             package size gv_number.
        ...
    endselect.
```
---
## SELECTING DATA FROM MUNLIPLE DB TABLE
&nbsp;&nbsp;&nbsp;<B>B2.P648</B>  

    중첩 SELECT문은 사용하지 말라.

---
### ABAP JOIN

alias명과 컬럼은 "~"로 연결한다.    
alias 설정 방식이 `DBTable AS A`방식만 가능함 "A" 사용불가능

#### OLD OPEN SQL의 제한사항
1. old Opensql은 INNER JOIN & LEFT OUTER JOIN만 가능함
2. Fixed value 사용 불가능 ()
3. 컬럼간 연산 불가능
4. No case expressions
5. NO SQL Function
6. Equal join만가능함
7. left outer조인할때 우측 테이블 ㄹ컬럼 사용 불가능
8. UNION, UNION ALL 사용 불가능

#### New Open SQL

- ABAP 데이터에 @를 추가해서 진행함.  
- 컬럼간 ,를 이용하여 구분한다. 
- INTO절의 위치가 지정되지 않는다.    
- CASE구문 사용가능  
- 컬럼 연산 가능함.
- UNION, UNION ALL 사용 가능함.  

```abap
    select c1,c2,c3,c4
    from sbook
    into table @lt_bookings
    where customid = @lv_customer.
```
