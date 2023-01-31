# DATA Modeling & Retriebal

## T-code
    ST12 - single transaction analysis
[**ST12 사용 관련 참고 사이트**](https://blog.naver.com/PostView.naver?blogId=hyuk4132&logNo=222521918758&parentCategoryNo=&categoryNo=19&viewDate=&isShowPopularPosts=true&from=search)  

---
## Data Models  
**B1.P438**  
 | | |
 |---|---|
 |||
 |참고사항 | <ul><ol>실무에서 모델링은 안한다고 볼 수 있다.</ol><ol>대부분 sap standard에 테이블을 맞춤.</ol><br>Dictionary에서 테이블 ERD 확인 및 작성이 가능함.<ul><br>DB ERD 단축키 Ctrl+Shift+ f11<br>DB Record 단축키 Ctrl +Shift +F10 </ul></ul>|

 ## Transparent tables
 **B2.P442**    
|구분|설명|
|:---:|:---|
|간단한 정의 | DB 테이블에 대한 정의서  |
|주용도 | DB서버에 테이블을 생성할 때 제작사양서와 같은 의미로 사용함.  |
|주의점 | 스트럭쳐 타입과 매우 유사하기 때문에 유의할 것.<br> 스트럭쳐에는 MANDT와 식별자개념이 없음. |

|||||
|   :---:   |   :---:   |   :---:   |  :---:  |
|Transparent table|||
| Described by └|data elements|
||Pointinting To└|domain|

아밥 딕셔너리에 생성한 Transparent table은 data element를 사용하는데,   
이는 테이블의 해당 컬럼의 속성을 설명하고 도메인을 포인팅하고 있다.

- DB ERD는 딕셔너리에서 Ctrl +Shift +F11  
- DB Record는 딕셔너리에서 Ctrl +Shift +F10

## Retrieving single DB Record
    ABAP은 Open SQL과 SQL을 이용하여 DB에 접근한다.

---
### Open SQL 
**B2.P453**  
||Open SQL 흐름|Native SQL 흐름|
|:---:|:---:|:---:|
||ABAP Open SQL문|SQL in ABAP|
||↓|↓(LAN)|
||DBI|DB Server|
|↙|↓|↓(LAN)|
|Table Buffer|SQL 번역|출력|
|↓|↓(LAN)||
|DBI|DB Server||
|↓|↓(LAN)||
|출력|출력||
<p>
<ul>
<li>Open Sql은 DB서버와 Dialog Work Process사이의 DB interface에서 SQL어로 변환됨.</li>
<li>Table Buffer를 사용함.</li>
<li>특별한 경우가 아니면 90% Open SQL을 사용함.</li>
</ul>
</p>
<p>
☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆<br>  
&nbsp;&nbsp;&nbsp;&nbsp;Primary 값을 이용 Hash index를 자동으로 생성<br>
&nbsp;&nbsp;&nbsp;&nbsp;Key-hash를 이요해서 Binary search가 가능하다.<br>  
&nbsp;&nbsp;&nbsp;&nbsp;따라서 O(logn) 으로 속도상 이득이 있음.<br>  
☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆<br>
</p>

#### Basic DB Read Access
```open SQL
    SELECT '컬럼명' FROM '테이블명' INTO 'Work Area 스트럭쳐명' [ WHERE '조건'] .
```
---
#### Retrieval of one Row of Data
**B2.p457**  

조건에 맞는 모든 데이터 중 한건을 조회.
- FROM 절과 INTO 절은 순서 상관 X
- SY-SUBRC는 데이터 조회 성공/실패를 알려준다.
- select *은 테이블과 into 스트럭쳐 구조가 동일할때 사용가능.
- 대상 테이블 컬럼 순서와 스트럭쳐의 순서가 동일하다면 SELCT 절에 컬럼 순서를 맞춰서 작성하면 문제없음  
<p></p>

**B2.P458 참고**


```abap
    SELECT SINGLE *
    FROM '테이블' 
    INTO '스트럭쳐변수'  
    WHERE '조건'
```

---
**★★★★★★순서에 맞춰서 알아서잘 컬럼 맞춰주는 방법★★★★★★★**

```abap
    SELECT SINGE '컬럼2' '컬럼1'
    FROM '테이블'
    INTO CORRESPONDING FOELDS OF '스트럭처'
    WHERE '조건'.
```
---
## Retrieving Multiple DB Record
     크게 두가지 방법을 이용해서 테이블 정보를 불러옴.
### SELECT LOOP
- 반복횟수는 SY-DBCNT 시스템 변수를 활용함. (데이터베이스 카운터)
- 문법상 ENDSELECT.가 필요함.
```ABAP
    SELECT '컬럼'
        FROM 'DB'
        INTO '스트럭처'
        [WHERE '조건']
    ENDSELECT.
```
## [**select loop.code**](/ABAP_source_code/week2/selectloop.abap)

### array fetch
N건의 데이터 묶음을 조회하여 abap 테이블에 출력하는 방법. <br> 퍼포먼스 이득

```abap
    select '컬럼'
    FROM 'DB'
    INTO TABLE '테이블'
    [WHERE '조건']
```

## [**select_array_fetch**](/ABAP_source_code/week2/select_arrayfetch.abap)

---
## Describing DB Access
**B2.P484**  

### Key Index Search
 db의 MANDT = 클라이언트 번호

Open sql 은 DB Interface 통해 DB에 접근하기 떄문에 자동적으로 클라이언트 handeling이 이뤄진다.  
따라서 클라이언트 조건을 추가하여 다른 클라이언트의 데이터 정보에 접근할 수 있다.
```abap
    select * from 'DB'
    client specified
    into ..
    where mandt = '클라이언트번호' and 
    '조건'
    .
```
만약 모든 클라이언트의 정보에 접근하기 위해서는 **MANDT 조건 없는 데이터 조회**로 접근이 가능하다.
```abap
    select * from 'DB'
    client specified
    into ..
    where '조건'
    .
```

---
### Access Through a Secondary Index

    Key Index는 DBI에서 자동 HASH LIST로 저장됨. (제일 빠름)
    kEY이외의 접근자는 
    Secodary 인덱스를 통해  바이너리서치를 구현할 수 있다.
    하지만 저장속도는 느려짐!!

---
### SAP Table Buffer
**B2.P488**  

DB 네트워크 접근이 아닌 클라이언트와 동일한 서버에 접근 가능하도록 생성해놓기.

---
### DB JOIN
**B2.P492**  

<UL>Open sql의 JOIN은 MANDT와 JOIN KEY를 동시에 사용함.</UL>
<UL>MANDT는 DBI에서 자동으로 조율하기 때문에</UL>
<UL>손코딩에서 SQL JOIN문법과 동일하다.</UL>
<UL>일반적으로는 View를 생성해서 ABAP Dictionary에서 접근함.</UL>

---
### Write Access To DB
**B2.P493**

## Authorization Check
**B2.P494** <br>  **한국에서는 잘 안씀.**
<ul>
<li>접근 권한 정보는 유저 마스터 레코드에 프로필 형태로 저장되어 있음</li>
<li>Auth Profile은 Object class로 정의된다.</li>
<li>Auth Profile은 [접근 가능한 컬럼(필드),가능한 권한]<br> 2가지 정보를 포함한다.</li>
</ul>

- 권한 체크 방법은 손코딩과 PATTERN 출력 2가지 방법이 있음  
1. 손코딩
```abap
    AUTHORITY CHECK
        OBJECT 'AUTH OBJECT명'
            ID  '필드' FIELD '조건'
            ID  '권한' FIELD '조건'.
```
2. pattern
    네비게이터 tool - pattern - AUTH CHECK 




    