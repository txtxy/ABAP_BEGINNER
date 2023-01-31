# **ABAP Workbench**


## 정의
Module = Software Component


## T-code 
|T-code| 기능|
|:---:|:---|
| SE84 | Repositary information system|
| SE80 | Object Navigator|
| SE11 | ABAP Dictionary|
| SE37 | Function Biulder|
| SE24 | Class Builder|
| SE38 | ABAP Editor|
| SE93 | 신규 트랜잭션 생성 및 MODIFY, DELETE|
| SE09 | 트랜스포트 편집기|

## 단축키
|단축키 | 설명|
|:---:|---|
| Shift +f12 | 툴에어리어를 전체화면으로 온/오프|
| Crtl+Shift+F5 | 툴에어리어와 오브젝트 카탈로그 동기화  |
|  |왼쪽 이랑 오른쪽이랑 같은곳을 바라보게 만든다.|
| Ctrl + < | 선택 항목 주석 처리 단축어|
| f1 | ABAP 키워드에 커서를 놓고 F1을 누르면 문법 확인 가능|
| Shift +f8 | 엑티브 버전과 인엑티브 버전 을 확인 가능|
| f4 | 입력창에 예시 혹은 입력 가능 테입블 확인 가능함.|

## B1.P191
1. 패키지생성
2. 개발
3. 단위테스트
4. 트랜잭션 생성
5. Transfer to QAS
6. PRD server로 Realese


### Repository는 크로스 클라이언트(Cross Client)다.
    Client Independent (클라이언트 독립적)
    여러 클라이언트에 똑같이 적용됨.


### Applicaation data, customizing data 
    Client-specific 
    클라이언트 종속적이다.
    극히 일부의 데이터만이 클라이언트 간의 공통 데이터로 존재하기도 한다.
    

- T-code se84 : 프로그램 라이브러리 접근 코드임.

************개발시 중요 T-code***********

- se80 오브젝트 네비게이터  
    기본 바탕화면 느낌

- SE11 아밥 딕셔너리  
    데이터베이스에 뷰 테이블, 데이터 타입 등을 생성할때 사용
    아밥 딕셔너리에서 생성한 데이터 타입은 global 속성이다.
- SE37 펑션 빌더    
    펑션 모듈을 생성 관리하는 프로그램

- SE24 클래스 빌더  
    OOP를 접목시킨 클래스를 생성 관리할 숫 있는것

- SE38 아밥 에디터  
    기본적인 소스코드 생성가능

아래는 잘 안씀 몰라도 됨.

   - T-code SE41 메뉴 페인터  
        메뉴바에 메뉴를 생성하는 프로그램

   - T-code SE51 스크린 빌더  
        프레젠테이션에 나오는 스크린을 만드는 프로그램


오브젝트 네비게이션

    Shift +f12 툴에어리어를 전체화면으로 온/오프

    어플리케이션 성격 혹은 설정에 따라 상단 툴바는 변경됨.

    툴에어리어와 오브젝트 카탈로그는 달라질 수 있다.

    Crtl+Shift F5 툴에어리어와 오브젝트 카탈로그 동기화

# ABAP 개발 프로젝트 진행
## B1.P25
    SE80 package input 을 통해 패키지 생성
    필수 정보는 Package name,short Description
    선택적 정보는 Application Component

>**DEV server**에서 개발된 프로젝트는 
**QAS Server**를 통해 통합 테스트 후
**PRD Server**로 최종적으로 Transfer 됨.

각각 서버를이동핼때는 체인지 리퀘스트 생성하고 패키지를 생성한다
 즉, 컨테이너(체인지 리퀘스트)를 먼저 만들고 포장상자(패키지)를 만든다.


---

**프로젝트 개발**에는 먼저 패키지를 생성해야한다.
Customer 생성 오브젝트는 Z혹은 Y를 무조건 앞에 넣어서 생성해야함.
패키지는 페포지터리 오브젝트를 관리하는 관리 단위

- T-code SE09 change Request (트랜스포트 편집기)  
    - f6 단축키 create Request  
        - 기본적으로 abap 개발시에는 워크벤치 리퀘스트 설정을 이용하고
        컨설턴트가 최초 설계할때 이용하는 것이 커스토마이징 리퀘스트임.

리포지터리 오브젝트의 이름은 Unique 조건을 만족해야한다.

체인지 리퀘스트는 완성한 패키지를 다른 서버로 트랜스포트할 때 사용하는 단위

    기본 제공되는 Basic SAP Object 또한 변경가능하다 이때에는 트랜스포트 레이어사 SAP이다.
    추가 제작 Object의 트랜스포트 레이어는 ZDEV 이다.

## B1.p212~213
### ABAP 개발의 순서

1. 프로그램 생성  
    프로그램의 생성은 오브젝트 네비게이터 혹은 아밥에디터에서 생성 가능하다.
2. ABAP 에디터를 통해 ABAP 코드 작성  
3. ABAP 프로그램 구동  
    ABAP 프로그램 또한 패키지와 마찬가지로 Z혹은 Y로 시작해야함.


ABAP 작성시 클래스 등 명령어를 작성하는 와중에 Tab 키혹은 Ctrl+Space를 누르면 예문이 뜨게 됨.

Ctrl+ F3 Activating  
    코드 실행 이전에 꼭 해줘야함. 일종의 컴파일 과정 

---
## B1.P214 ABAP 언어의 특징
    데이터 타입 적용
    다중언어 적용
    SQL 접근가능
    OOP 가능한 언어
    운영체제 독립성
    상위 버전 사용가능

## B1.P215 ABAP 문법 구조

키워드는 대소문 구분 하지 않는다.
단어와 단어사이에 하나이상의 공백으로 구분

`ABAP-KEYWORD'*Space*'ADDITIONAL-KEY.`

---

## 기본 문법
    " : 이후부터 주석 = Double Quotation
    "*" 이 줄 전체 주석
    Ctrl + , : 선택 항목 주석 처리 단축어
    ":"와 "," : 사용시 연결되어 문법사용
    한문장을 여러 라인에 걸쳐 사용 가능 (SQL과 비슷)
    기본 스크린 번호는 1000번
    소스 코드 저장 이후에 Activate는 필수!


## Data Type
integer = i


## 주요 키워드
1. write 'A'. " 프린트 명령어  
ex ) `write 'Hello World'.`
    다중 출력시에는 write: A,B. 방식 사용.  
    write:/ 슬래쉬 작성시 new-line이 적용됨.  
    정렬 left-JUSTIFIED 혹은 right-JUSTIFIED  
    형태와 관련된 사항은 doc의 informat 사항 확인 필요.  

2. parameters A type B. " 스크린생성 명령어 변수 A에 type은 B로 생성  
ex) `parameter pa_num type I.`

3. data A type B . : 변수선언문 A변수를 B타입으로  
ex) `data gv_result type i.`

4. move A to B. " A값을 B에 적용.  
Ex) `move pa_num to gv_result.`

5. add A to B. " B에 A를 추가  
Ex) `add 1 to gv_result.`

6. new-line. " 새로운 라인 생성  
Ex) `new-line`

## ABAP 키워드 문법
    F1을 통해 DOC을 들어가면 해당 문법 Syntax 확인가능
    []는 Optional 파라미터임.

Utilities Setting -ABAP Editor 탭에서 에디터 스킨 변경 가능
 클래식 에디터는 노트패드 느낌.

Utilities -settings -ABAP Editor
    Indent는 꼭 체크해놓을 것
    pretty Printer탭에서 소스코드의 대소문자 변형이 가능함.
    이후 에디터 네비게이터 툴에서 Pretty Print를 누르면 자동 변형됨.

에디터 우측 최하단에서 Personalizing 가능

모든 프로그램의 소스코드는 서버 레포지토리에 저장되어야하기 때문에 프로그램을 엑티브 시켜서 레포지토리에 등록하는 과정을 진행해야함.

미사용 TEMP 소스코드의 경우 LOcal Object 로 생성해서 관리함.
이렇게 하면 Change Request를 요청하지 않음.


---

## 단축키
- 트랜스포트 편집기에서   
    F9 : Realese Directly

    엔드 유저가 프로그램을 사용하기 위해서는 트랜잭션 코드가 필요하다.

## B1.P227
---
1. 트랜잭션 코드 생성한다.
2. 체인지 리퀘스트를 배포한다.
---
    트랜잭션 코드 생성은 패키지에서 우클릭으로 생성 할 수 있고,  
    일반적으로 프로그램 이름과 트랜잭션 코드를 동일하게 제작한다.
---
    트랜잭션 생성시에는 START OBJECT 를 선택해야함  
    abap 에는 크게 2가지 종류의 프로그램으로 나눠짐.


## B1.P232

1. **SCREEN PROGRAM**  
    다른 이름 : Module Pool ;Type M  
    CRUD를 실행할 수 있는 프로그램

---
2. **REPORT PROGRAM**  
    다른 이름 : EXECUTABLE PROGRAM; Type 1  
    기본적으로 결과물을 출력하는 것은 레포트 트랜잭션  
    정식 명칭은 EXECUTABLE PROGRAM

---
3. **Function group**  

---
4. **interface pool**

---
5. **class pool**

---
6. **Include Program**

---

어느 SAP GUI 에서 지원할 것인지를 설정해줘야하며 프로그램 이름도 알려줌.

- 트랜스포트 편집기에서 배포할 시  
    - 자동으로 문법 및 엑티브 되어있는지 확인이 진행됨.
    - 배포가 시작되면 자동으로 모든 오브젝트에는 Lock이 걸림.

