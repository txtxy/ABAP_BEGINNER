# SELECTION SCREENS
**&nbsp;&nbsp; B4.P290**  

## 셀렉션 스크린구현
### Default SCREEN 1000 
parmeter , select-option로 제작한 스크린과
Losical DB로 생성한 (Keyword`NODES ..` 로 제작한) 스크린은
SCREEN 1000 이 기본 값으로 지정됨.

### variant
    스크린의 입력된 값을 저장해서 재사용하는 것.
    간단히 말해 입력값과 스크린을 동시에 저장하고 이용하는것.

---

```abap
    selection-screen begin of screen 1100.
    ...
    selection-screen end of screen 1100.
```
### parameter select
**&nbsp;&nbsp; B4.P292**  
해당 페이지는 parameter의 Documentation 이 작성되어있음

|parameter의<br>additional 문법| 설명|
|:---:|:---|
| MEMORY ID \<pid\>| IMPUT 값을 SAP Memory에 저장하고<br>이후 프로그램 실행시 memory에서 불러옴|
| OBLIGATORY| 해당 필드 값을 필수로 요청함.|
| LOWERCHECK| 입력값의 대소문자를 구분함.|
| VALUE CHECK.| select help 연결|
| AS CHECKBOX| 마우스로 선택할 수 있는 체크박스로 생성<br> 다중 선택가능함.|
| RADIOBUTTOON GROUP \<grp\>| 그룹명이 꼭 있어야함 <br> 해당 그룹중 한개만 선택해야함.|
| MODIF ID \<mod\>| 나중에 배울 예정|

#### !!셀렉션 스크린 생성 실습!!

[zabap_e01_032생성](../../ABAP_source_code\Week3\zabap_e01_032.ABAP)

- Selection TEXT를 통해 Text 설정도 가능함.
- RADIOBUTTOON의 경우 1개 변수에만 값이 지정될 수 있기 때문에  
 'X'를 상수로 지정하여 CASE 조건문을 사용한다.

---
### Selct-options Screen
**&nbsp;&nbsp; B4.P293**  

Internal Table의 Component로만 선언할 수 있음

|Sign|Option|Low|High|
 |:---:|:---:|:---:|:---:|
 |포함여부|조건연산자|최소값|최대값|
 |I|EQ|||
 |Inclusive|동일함|해당값|해당값|
 |E|BT|||
 |Exclusive|비트윈|||
 |위 두개가<br>끝!|...|||
 
Selct-options는 위와 같이 테이블 구조이기 때문에 Multiple 선택이 가능함

**&nbsp;&nbsp; B4.P296**  
MEMORY ID <>를 사용할때에는 1개 값만 입력이 가능하다.  
- 기초적인 사항은 parameter와 동일함  

|Selct-options의<br>additional 문법| 설명|
|:---:|:---|
| NO-EXTENSION <pid>| 우측 확장입력칸이 등장하지 않음.|
| NO INTERVALS | 두번째 입력칸이 Display되지 않음.|

#### !!셀렉트 옵션 스크린 생성 실습!!

<b>zabap_e01_033 생성</b>

---

### INITIALIZATION.
**&nbsp;&nbsp; B4.P297**
- REPORT Prg에서만 발생 가능한 이벤트.
- 이벤트 종료 후 ENDUSER에게 SCREEN을 DISPLAY
- 값을 동적으로 할당할 수 있음(값에 변수 입력가능함.).

### AT SELCTION-SCREEN
- Check Logic을 통해 SECT SCREEN에 입력된 값을 CHECK 하는 이벤트.
- 이벤트 실행 TIMING은 SELECT SCREEN EXECUTE 직후 실행
- Dialog message E를 이용해서, 체크 메시지를 Display함.  
    즉, Status bar에서 확인가능.
- 오류 체크에 문제가 있으면 다시 스크린 display
- 오류 체크 통과 이후에 메인 소스코드가 시행됨.

---
### SELECTION SCREEN BLOCKS
**&nbsp;&nbsp; B4.P299**
- SELECT SCREEN을 BLOCK으로 나눠서 DISPLAY.
- BLOCK의 이름은 임의의 문자열로
- TITLE 구문 뒤에 TEXT SYMBOl을 이용하여 제목을 Display할 수 있다.

```abap
    SELECTION-SCREEN BEGIN OF BLOCK   blk1    WITH FRAME   TITLE TEXT-001.
                                    블럭이름  프레임 만들기  제목
    SELECT-OPTIONS: so_car FOR gv_carrid ,
                    so_con FOR gs_flight-connid ,
                    so_fdt FOR gs_flight-fldate .
    SELECTION-SCREEN END OF BLOCK blk1.

```
### selection-screen Lines
**&nbsp;&nbsp; B4.P300**
- 라디오버튼이나 체크버튼 같은경우 1 줄에 DIsplay할때 사용하는 기능
```abap
    SELECTION-SCREEN BEGIN OF LINE.
        * pos_low는 그 다음으로 올 수 있는 값의 최소 거리를 만들어준다.
        * POS_LOW와 POS_HIGH는 컬럼 상수값으로 변경할 수 있지만 값이 서로 겹치게 만들어서는 안된다.
        * FOR Field는 코멘트와 체크 박스를 연결해주는 문법
    SELECTION-SCREEN COMMENT pos_low(14) TEXT-c02 FOR FIELD pa_eco.
    PARAMETERS: pa_eco AS CHECKBOX.

        * FOR Field가 설정되지 않았기때문에 Display Sccreen에서 설명문과 체크박스는 별도요소로 인식됨.
    SELECTION-SCREEN COMMENT pos_high(14) TEXT-c03.
    PARAMETERS : pa_biz AS CHECKBOX.

    SELECTION-SCREEN END OF LINE.
```
### SELECTION SCREEN COMMENT
- 스크린에 코멘트 작성할때 사용
```abap
    SELECTION SCREEN COMMENT 1(20) text-001
    *SELECTION SCREEN COMMENT 위치 (글자길이) 텍스트 심벌              
```


<a href="../../ABAP_source_code\Week3\zabap_e01_033.abap">스크린 소스코드</a>

---

<h2 align =center><b>UNIT10 EX21</b></h2>

인클루드 프로그램은 한개의 메인 프로그램만 사용해야한다.
두개이상의 메인 프로그램이 같은 인클루드 프로그램을 사용한다면  
독립성을 해치게 된다.

DV_ : DATABASE VIEW 접두사

인클루드 방식을 잘 사용하자
 = 패키지 생성 방식

---

## 멀티플 스크린 구현
- 기본 적으로 1100번으로 Reserved
- 셀렉션 스크린에 추가 팝업으로 셀렉션 스크린을 등장 시키는 것을 말함?

## TABstrips
- 너무 많은 선택 Field가 존재할 때  
    선택창을 관련된 필드끼리 TAB으로 분리해서  
    선택창을 Display할 수 있음.
- 이때에는 Subscreen이 필요하다.

### Subscreen 선언을 먼저하고
```abap
    SELECTION-SCREEN BEGIN OF screen 101 as subscreen.
        SELECT-OPTIONS: so_air FOR gs_flight-carrid,
                        so_con FOR gs_flight-connid.
    SELECTION-SCREEN END OF screen 101 .

    SELECTION-SCREEN BEGIN OF screen 102 as subscreen.
        SELECT-OPTIONS: so_air FOR gs_flight-custtype.
    SELECTION-SCREEN END OF screen 102.

    SELECTION-SCREEN BEGIN OF screen 103 as subscreen.
        SELECT-OPTIONS: so_air FOR gs_flight-fldate.
    SELECTION-SCREEN END OF screen 103.
```

### TAB block 사용을 선언
- 각각의 탭 패이지의 이름의 텍스트 셀렉션은
    INITIALLIZATION 이벤트에서 설정한다.
- 참조 코드1 <a href="../../ABAP_source_code\Week3\zabap_e01_034.abap">ZABAP_E01_034</a>
- 참조 코드2 <a href="../../ABAP_source_code\Week3\zbc405_sol_e01.abap">zbc405_sol_e01</a>

```abap
    SELECTION-SCREEN BEGIN OF TABBED BLOCK TAB_BLOCK FOR 5 LINES
                               탭으로 이뤄진 블럭 선언    5줄의 크기를 가짐
        SELECTION-SCREEN  TAB (10) tab1 USER-COMMAND comm1 DEFAULT SCREEN 101.
        *          탭페이지 타이틀의 길이 탭이름    커맨드 이름     위에 선언한 보여주고 싶은 스크린
        *                                       USER-COMMAND =  선택될 탭에대한 변수명 선언.
        SELECTION-SCREEN  TAB (10) tab2 USER-COMMAND comm2 DEFAULT SCREEN 102.
        SELECTION-SCREEN  TAB (10) tab3 USER-COMMAND comm3 DEFAULT SCREEN 103.

    SELECTION-SCREEN END OF BLOCK TAB_BLOCK.

    INITIALIZATION.
    * 텍스트 셀렉션 설정

        tab1 = text-tb1.
        tab2 = 'Flight'(tb2)
        tab3 = 'BOOKING'(tb3)
    * 초기값 설정하기

        tab_block-activetab = 'COMM2'.
    * 선택되어 진것으로 보여질 탭변수를 선언
    * 주의점 : 유저커맨드 이름을 소문자로 했다고하더라도 CALL 할때는 무조건 대문자로

        tab_block-dynnr = 102
    * 보여지는 스크린 선언하는것임 acivetab의 User-command에 맞춰서 스크린 선택하라

    * 만약 스크린과 유저 커맨드가 다르게 설정되면.
    * 탭 선택은 액티브 탭처럼되고
    * 스크린 화면은 설정된 스크린 화면으로 엉켜서 나옴.
```

---

<h2 align =center><b>UNIT10 EX22</b></h2>

---
## INPUT Check & Creating Variants
**&nbsp;&nbsp;&nbsp;B4.P320**

### INPUT Check
셀렉션 스크린에 입력된 값들은
AT SELECTION-SCREEN 에서 정합한 값인지 체크하게 됨.
- 기본적인  CHECK 구문
```abap
    AT SECECTION-SCREEN ON so_dept.
    * so_dept에 입력된 값을 체크할것이라고 선언.
    IF ... 
        message e046(bd405).
    *   bd405에 작성된 메시지 타입 'E'의 046번 메시지를 호출
    else.E
    endif.
```


### F1 HELP
**&nbsp;&nbsp;&nbsp;B4.P321**
```abap
    AT SELECTION-SCREEN ON HELP-REQUEST FOR so_dept
        call screen 100 starting at 30 03
                        ending   at 70 10.
```
HELP DOCS 를 띄워주는 기능에 관한 설명

오픈 다이얼로그를 띄워서 특정 파일을 선택할 수 있게끔 할것임.
ON HELP REquest는 실무에서 거의 사용하지 않음.

CL_GUI_FRONTEND_SERVICES : 스탠다드에서 제공해주는 서비스 클래스
    자식 METHOD FILE_OPEN_DIALOG : F4를 눌러 윈도우 GUI에서 파일 찾기

### Variants

 프로젝트할때 테스트 값 저장해놓고 불러올때 자주 사용함.
생성 및 조회 위치

1. Variants 생성
    1. 스크린 화면에서 테스트 사항 입력하고서
    - ![Varients 생성](../screenShot/WEEK3/Varients_creation.png)
    2. 베리언츠 저장하기!
    - ![Varients 생성](../screenShot/WEEK3/Saving_varients_session.png)

2. ABAP Editor T-code SE38 에서 VARIENT 생성 및 조회 가능