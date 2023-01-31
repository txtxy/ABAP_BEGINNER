# Abap List View

20년 전부터 WRITE구문은 사용하지 않는다.  
대신에 <b>ABAP List Viewer(ALV)</b>를 사용한다.

## Reporting Tool
END-USER가 정보를 얻기 위해 사용하는 방식
1. SAP Query
2. InfoSET Query
3. Quick Viewer

---
## Implement Naming Convention (네이밍 룰)

|Prg TYPE|NAMING Rule|
|:---:|:---:|
|MAIN Prg|ZDEMO_00|
|TOP INCL|ZDEMO_00_TOP|
|PBO|ZDEMO_00_O01|
|PAI|ZDEMO_00_I01|
|EVENT|ZDEMO_00_E01|Parameter의 argument로
|Subroutine|ZDEMO_00_F01|
|Class|ZDEMO_00_C01|

---
## Implement simple List

### WRITE Additional Keyword

|keyword|설명|
|---|---|
|NO-GAP|","를통해 변수를 붙일때 빈자리 없이 붙임.|
|NO-ZERO|NUMC의 경우 앞자리에 오는 0을 삭제함.|
|DD/MM//YY| DATE로 표시|
|CURENCY *\<currencyKey\>*|화폐단위를 이용하여 표시|
|UNIT *\<unit_key\>*| 단위를 이용 하여 표시|
|UNDER *\<g\>*| 밑줄 긋기 |
|LEFT-JUSTIFIED|좌로 정렬|
|CENTER|가운데 정렬|
|RIGHT-JUSTIFIED| 우로 정렬|
|USING EDIT MASK *\<mask\>* | 해당 문자열을 mask CHARCTER로 마스킹<BR> EX)주민등록번호<br>`WRITE :/ gv_regno USING EDIT MASK '______-_******'.`<br>`WRITE :/ gv_telno USING EDIT MASK '(___)____-____'.`<br>![MASKING_Used](../screenShot/Week5/Using_Edit_mask.png)|



## PARAMETERS SYNTAX
&nbsp;&nbsp;&nbsp;&nbsp;**B.BC405P.31**

parameter에서는 SCREEN그룹을 1개만 사용할 수 있다.

## SELECT-OPTIONS SYNTAX
&nbsp;&nbsp;&nbsp;&nbsp;**B.BC405P.32**

S-O는 선언과 동시에 같은 이름의 INTERNAL TABLE WITH HEADERLINE이 선언된다.

CP는 SQL 의 LIKE 조건과 유사함


레포트 프로그램에 동적 변화를 주기위해서는

CALL SELECTION-SCREEN 0000

구문을 사용한다

만약 체크박스를 선택하면 넘어가도록 하고 싶으면
```ABAP
    if pa_add = 'X'.
        CALL SELECTION-SCREEN 1100
            [STARTING AT 5 5].
```

<a href="../Week3/SAP_TAW10_ABAP DDIC_UNIT10.md">교재상 내용 참고</a>

## input check & Variants
&nbsp;&nbsp;&nbsp;&nbsp;**B.BC405P.60**

## MODIFYING SELECTION-SCREEN AT RUNTIME
&nbsp;&nbsp;&nbsp;&nbsp;**B.BC405P.70**

AT SELECTION-SCREEN 은 M TYPE 프로그램의 PAI와 같고  
AT SELECTION-SCREEN OUTPUT 은 M TYPE 프로그램의 PBO와 같다.  

`TABLES: sscrfields.` 유저커맨드의 입력사항은  
데이터 오브젝트를 선언해서 활용해야한다.

push 버튼의 입력 처리는 M TYPE과 마찬가지로  
AT SELECTION-SCREEN 이벤트에서 처리된다.

SELECTION SCREEN에서의 유저 커맨드 입력은  
SSCRFIELDS-UCOMM 이라는 COMPONENT에 저장된다.


동적인 변동사항은 Mtype의 PBO와 같은 AT SELECTION SCREEN OUPUT에서 진행한다.  

Mtype 과 마찬가지로 sscrfields 테이블에서 LOOP를 돌면서  
그룹명을 조건으로 처리사항을 진행한다.

그룹 지정은 `MODIF ID <GROUP>` Additional Keyword를 통해 부여한다.

![Repot Prg에서 SCREEN 보는 법](../screenShot/Week5/Report_Prg_SCREEN_.png)

```ABAP
      SELECTION-SCREEN PUSHBUTTON /pos_low(20) gv_btn USER-COMMAND btn.


    SELECTION-SCREEN END OF BLOCK blk2.


    INITIALIZATION.

      so_car-sign = 'I'.
      so_car-option = 'EQ'.
      so_car-low = 'UA'.
      APPEND so_car.

      gv_btn = 'Diplay/Change'.   " 버튼의 표시명


    AT SELECTION-SCREEN.
      CASE sscrfields-ucomm.
        WHEN 'BTN'.
          IF gv_mod = 0.
            gv_mod = 1.
          ELSE.
            gv_mod = 0.
          ENDIF.

      ENDCASE.

    AT SELECTION-SCREEN OUTPUT.
      LOOP AT SCREEN.
    *    IF screen-group1 = 'MOD'.   " 그룹을 기준으로 변경할때

    *      screen-input = gv_mod.   " 입력 가능한지를 변화시키고 싶을때
    *      screen-active = gv_mod.   " 보이는 지를 변경하고 싶을때
    *      MODIFY SCREEN.
    *    ENDIF.
        if  screen-name cs 'so_con'.   " 이름으로 할때에는 꼭 CS를 사용해야한다.
          screen-active = gv_mod .     " 왜냐면, sscrfields에 저장된 이름에 특수문자가 포함됨  
         MODIFY SCREEN.
        endif.
      ENDLOOP.
```
![CS를 써야하는 이유](../screenShot/Week5/Reason_to_USING_CS.png)

CS는 해당하는 문자가 포함되어있다면이라는 논리연산자!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


---

과거에 생성했던 ZABAP_E01_033 프로그램으로 실습

---

## ALV의 기능들
  SAP에서 활용하는 결과 리스트 출력 방식  WRITE를 대체했음.  

디스플레이 방식은 크게 3가지 방식이 있음  
1. Container 
2. Full screen
3. List

### ALV의 생성 필요사항

1. 기본적으로 REPORT 프로그램  
2. 1000번 기본 (SELECTION-SCREEN)
3. ALV 표시를 위한 추가 SCREEN  
4. Custom Container AREA
5. Cotrol Container
    - 이 Container를 AREA로 ALV Object를 생성한다.
6. ALV_GRID

### Container의 구성요소 (UI)

![ALV_DISPLAY_SMPLE](../screenShot/Week6/ALV_grid_display.png)
1. Application Tool bar
    - Optional로 Selection 가능
2. List Heeader(Optional)
3. Data (ALV리스트의 좌측부터)  
    
    1. SELECTION BUTTON (OPTIONS)
    2. KEY column
    3. TOTAL /SUB TOTAL 생성 가능
      - 수형식 컬럼의 합계 등 산술 기능

### MOUSE Function 활용 가능함

## Container Screeen for ALV Grid Control
&nbsp;&nbsp;&nbsp;&nbsp;**B.BC405P.96**

  일반적으로 Report 프로그램에서 100번 SCREEN으로 생성함.

대체로 실무에서는 Tamplete으로 만들어서 활용함.

---
### Grid Container WORK FLOW
&nbsp;&nbsp;&nbsp;&nbsp;**B.BC405P.97**

#### **Grid Container AREA 생성 순서**

1. ALV가 표시될 SCREEN 생성 (Normal)   
2. Screen Layout에 Custom Control area 생성
3. 생성한 AREA의 "이름"으로 컨테이너 지역 할당됨.
4. PBO에 STATUS 생성

-------------컨테이너 생성 실습 --------------------------*  
REPORT ZABAP_E01_036.  
**INCLUDE 프로그램을 사용하는 방식을 실습**  

-------------컨테이너 생성 실습 --------------------------*  
Ex.7) P.107  
**Master Prg만 사용하는 방식을 실습**  

## ALV-GRID 생성 
&nbsp;&nbsp;&nbsp;&nbsp;**B.BC405P.115**  

ALV를 사용하기 위해서는   
1. CUSTOM CONTROLL AREA를 SCREEN에 생성하여
2. 해당 AREA에  CONTROL CONTATINER를 생성하고
3. 그 Contatiner에 ALV-GIRD를 생성하여
4. ALV-GRID 클래스의 METHOD를 이용하여 DATA를 전달한다.

---
### ALV-GRID 제작 순서

1. DATA DECLARATION.
    - CLASS를 이요하여 OBJECT를 생성하기 위해 참조 변수를 선언힌다.  
      `DATA : <OBJECT NAME> TYPE REF TO <CLASS NAME>.`
      
2. SCREEN CONTAINTNG CONTROLL_AREA
    - ALV가 출력되기 위한 Control Container 생성
    - Screen의 Layout에서 생성한다.

3. CREATE CONTAINER OBJECT 
    1. class name = CL_GUI_CUSTOM_CONTAINER
    - 생성방법
       - PATTERN - ABAP Object Patterns-Create Object
       - Navigator에서 DRAG & DROP
    - 주의사항
        - 참조변수가 포인팅하는 오브젝트가 존재하지 않을 때만  
          오브젝트를 생성하도록 조건문으로 설정

          ```ABAP
            IF <인스턴스> IS INITIAL.
              CREATE OBJECT ...
            ENDIF.
          ```
          설정하지 않는다면, USER ACTION이 발생할때마다 오브젝트가 생성됨.

    2. Class Name = CL_GUI_ALV_GRID
        - 생성방법
            - Contol Container IF 조건문 내부의 CONTAINER 생성문 다음에 작성함.

4. Create ALV DATA Display   
    - CALL METHOD \<ALV GIRD NAME\>->set_table_for_first_display  

    - 생성한 Control Container에 DATA를 입력하는 Method 호출
    - i_structure_name 인자는 Optional이기에 없어도 문법오류 없음.  
    하지만, 입력되지 않는다면 Data를 불러올 수 없음.
    - ABAP DIcc 안의 DB뷰 xmfostmvpdjfjsxm dlfma ,스트럭쳐 타입

---
### **예시 코드**

```abap
    * 참조 변수명 선언

    DATA : go_container TYPE REF TO cl_gui_custom_container,
           go_ALV_GRID TYPE REF TO cl_gui_alv_grid.

    * OBJECT 생성 조건 설정

    IF go_container is INITIAL .              "  오브젝트 생성 조건문

    * 참조변수명을 기준으로 오브젝트 생성

        CREATE OBJECT go_container             " Container Object 생성
            EXPORTING                           
          container_name     = 'ALV_AREA'     " Container AREA name

    * ALV Grid 생성

        CREATE OBJECT go_ALV_GRID              " ALV-GRID Object 생성
          EXPORTING
            i_parent         = go_container    " Container  Object name

    * ALV Grid DATA 입력     
        * ALV-Grid에 DATA 입력 METHOD 호출
        CALL METHOD go_ALV_GRID->set_table_for_first_display    
          EXPORTING

          * 참조 STRUCTURE 전역변수 이름
            i_structure_name  = 'ZGS_SBOOKDAY_E01'  

          * LAYOUT 변경을 위한 변수 입력
            is_layout         = gs_layout           

          CHANGING             
           * DATA가 존재하는 Internal Table변수 입력        
            it_outtab         = gt_book            

    ENDIF.
```


#### Refresh ALV grid
실습은 불가능하나 프로젝트나 실무에서 사용하니 준비할 것

```abap
    go_alv->reftresh_table_display(
    is_stable = 
    i_soft_refresh =
    ).
```

## ALV-GRID의 SYS 변수

![ALV_SYS_VAL](../screenShot/Week6/ALV_grid_SYS_Val.jpg)

|-|Group|변수명|형식|설명|
|:---:|:---:|:---:|:---:|---|
|1| LAYOUT Info | LVC_S_LAYO | Structure |  |
|2| LAYOUT Info | UI_FUNCTIONS | Internal Table |  |
|3| LAYOUT Info | LVS_S_PRNT | Structure |  |
|4| DATA Info | LVC_T_SORT | Internal Table |  |
|5| DATA Info | LVC_T_FILT | Internal Table |  |
|6| DATA Info | LVC_T_SGRP | Internal Table |  |
|7| DATA Info | LVC_T_FCAT | Internal Table | ITAB의 필드에 속성값 지정 |

