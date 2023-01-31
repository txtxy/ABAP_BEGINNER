# SCREEN PROGRAM
a.k.a. MODULE POOL Prg; Type M Prg  
---


**&nbsp;&nbsp; B4.P334**  

- 레포트 프로그램보다 조금 복잡하게 느껴질 수 있다.
- T-code를 생성하지 않으면 실행되지 않는다.
- 아밥에디터에서 프로그램 생성하고 스크린도 따로 생성해야한다.

## Single Screen Layout
**&nbsp;&nbsp; B4.P334**  
![스크린 레이아웃](../screenShot/WEEK3/Screen_Layout.jpg)

- 한개 화면에서 데이터 입력과 출력을 모두 할 수 있다.
- 즉, DATA CRUD를 한개 화면에서 진행 가능하다.

## Module Pool Prg 생성
**&nbsp;&nbsp; B4.P339**  

### 명명법
- Module Pool Prg의 Main Prg의 접두사는 SAPMZ 혹은 SAPMY

### 프로그램 생성시 주의사항
- Create TOP INCL를 꼭 체크해야한다.
- Screen Prg는 INCL Prg를 중심으로 작성됨.
    Module화와 OOP개념이 중요한 것 같다.
- 생성화면에서 Main Prg이름과 TOP이름을 동일하도록 작성하자.

### Module Pool Prg의 필수적인 INCL Prg
|개념|명명법|설명|
|:---|:---:|:---:|
|TOP include|MZ예시명TOP|전역변수 선언부 <br>Type Pools 라고 이해|
|EVENT include|MZ예시명E##| EVENT 사항 작성부|
|Form Routine 선언부|MZ예시명F##|Function이나 Subroutine 작성부|
|PAI(Process After Input) 모듈|MZ예시명I##|Input이후 진행되는 Logic 작성|
|PBO(Process Before Oouput) 모듈 |MZ예시명O##|Screen Display 이전에 시행되는 Logic|

### B4.P350
1. 스크린 속성
2. 스크린 엘리먼트
    1. 각 엘리먼트의 속성
3. 스크린 컴포넌트

#### SCREEN Prg 작성


---

<h3 align = center>!!실습!!</h3>  <br>

1. Type M 프로그램 생성
    - 이름은 sapzscreen_e01

2. create TOP INCL 선택하고 생성하면 
3. Type Pool 이름 짓고 생성 
    Main Prg 이름과 동일하게

---
<h3 align =center><b>UNIT11 EX24</b></h3>

1. Package 생성 - ZBC410_E01 
2. Type M Prg 생성 - SAPMZBC410_SOLUTION_E01
3. TOP 생성 


## SCREEN Prg 소개

- Module POOL 프로그램은 Dev workbench 에서도 무조건 T-CODE를 사용해서 실행한다.  
- Screen은 다른 Screen Element의 Container 역할을 할 수 있다.  

- Screen in Dialog Prg  
    PBO 와 PAI는 Screen의 Flow Logic에서  
    `MODULE ` Keyword를 사용해 생성할 수 있다.  

**&nbsp;&nbsp; B4.P351**  

### Attributes of Screen
    스크린에는 여러 속성의 리스트가 정의되어 있다.
    이 속성값들은 다른 스크린이나 포함 요소에 영향을 미칠 수 있는 속성도 존재한다.

1. Admin  
    Program이름이나 Screen Number와 같은 스크린을 정의하는 기본 속성들  
2. Type  
    스크린의 기본 형태를 정의하는 속성이며,       
    4가지 종류중 1가지의 형태를 가진다.  
    1. Normal  
        가장 기본 적인 스크린 형태이다.  
    2. Subscreen  
        스크린 컨테이너 내부에서 자용하는 스크린을 의미한다.  
        동적인 구성을 가능케한다.  
    3. Modal dialog box  
        팝업창의 형태로 존재하는 스크린의 형태를 의미한다.  
    4. Selection screen  
        아직 잘 모르겠다.  
3. Size  
     Modal dialog box의 경우 아래와 같은 문법으로 동적인 형태를 지정해 줄 수 있다.  
     `starting at 20 50`  
4. Sequence  
    기본적으로 스크린에는 다음에 올 스크린 넘버를 작성해서 업무 흐름을 지정할 있다.  
    Statctic 순서와 PAI에서 지정한 동적 순서를 모두 지정할 수 있다.  
5. Setting  
    스크린이 시작됐을 때의 커서 위치, 홀드 스크롤 포지션과 같이,   
    스크린의 개별 세팅과 같은 설정을 작성하는 속성들을 의미함.

### Components of Screen

#### Frontend 부분
-   스크린 속성을 설정할때 RAYOUT 버튼을 클릭하면  
스크린 페인터기능으로 이동할 수 있고,  
이곳에서 스크린에서 보여지는 요소들을 제작하고 설정을 지정할 수 있다.

#### Backend 부분
-   스크린의 Flow Logic에서  
PBO와 PAI로 나눠진 MODULE을 선언하여,  
스크린 프로그램이 진행된다.

### 스크린 생성
**&nbsp;&nbsp; B4.P353**  
-   t-code SE51 스크린 페인터  
거의 사용 안한다고 봐도됨.

-   SE80에서 스크린을 스크린 정보 화면에서  
RAYOUT버튼을 클릭하면 스크린에 맞춰서 SE51 기능 실행

#### 스크린 생성의 흐름
**&nbsp;&nbsp; B4.P354~357**  

1. 스크린속성 값 작성  
    기본 넥스트 스크린 번호는 본인의 스크린번호임.  
    넥스트 스크린 번호를 0으로 입력하면 뒤로가기임.  

2. 스크린 레이아웃 그리기  
    각 스크린의 Attribute 탭에서 확인할 수 있다.  
    스크린 페인터에서 필요한 요소를 생성함.  
    ABAP DICc를 통해 연결할 수 있는 Component를 배껴올 수 있음.  

3. 스크린 엘리먼트 속성 작성  
    스크린 페인터를 통해 만들어낸 요소들의 크기,타입 등이 작성되어있으며  
    이는 각 스크린의 Element 탭에서 확인할 수 있다.  

4. 플로우 로직 작성  
    `MODULE` Keyword를 이용해서 모듈명을 선언하고 소스코드를 작성함.  

---
스크린 생성 순서

1. 스크린 속성을 작성하여 스크린 생성  

    스크린 넘버와 스크린 타입을 입력하여 표시할 스크린을 정의한다.  
    일반적으로 Normal 스크린 번호는 100번대로 부여

2. 스크린 레이아웃 작성  

    레이아웃 수정 페이지에서 각각의 엘리먼트의 속성 편집가능  

3. 엘리먼트 속성 작성  

    Screen Element와 데이터 처리부의 컴포넌트는,    
    이름을 기준으로 Identification한다.  
    
4. 플로우 로직 작성(PBO,PAI 진행 순서)  

    Flow Logic Editor 탭에서   
    PBO 혹은 PAI 하단에    
    `MODULE 모듈명 `작성하고     
    모듈명을 더블클릭하면 각각의 Include folder 안에 생성됨.  

---
### DATA VISIBILITY
**&nbsp;&nbsp; B4.P358~369**

스크린 페인터에서 제작 한 엘리먼트에 입력된 값들은  
이름을 기준으로 Identipication된다.

#### Element의 Identipication
 1. Screen의 Element탭에서 확인
 2. Screen Pinter
    1. 확인을 원하는 Element를 더블클릭하거나
    2. Element를 선택하고서 F2를 눌러
        Screen Atribute창에서 확인할 수 있다.

이렇게 확인된 Name을 이용해서
ABAP Main Prg의 TOP(타입풀)에서 동일한 이름의 변수로 값을 할당한다.

**&nbsp;&nbsp;B4.P.358 예시 코드**
- 스크린 페인터에서 ABAP DICc을 통해 불러온 Field는  
    TOP INCL Prg에서도 변수로 선언해야한다.  
    이때 사용되는 키워드는 ` TABLES ` 이다.

```abap
    TABLES: sdyn_conn.               " 이것은
    DATA : sdyn_conn TYPE sdyn_conn " 이것과 같은 의미다.
```

스크린 Element를 SAP 메모리를 통해서 값을 전달 받고자 한다면  
SET ,GET Parameter로 Check해야한다.  

이는 Screen Painter의 Screen Attribute 창에서 체크하거나  
Screen Element list 탭의 special 탭에서 체크 및 확인이 가능하다.  


[스크린 프로그램에 관한 설명](https://blog.naver.com/l_yh6/221470196160)


---
<h3 align =center><b>UNIT11 EX25</b></h3>


## Modifying Screens at Runtime
**&nbsp;&nbsp; B4.P371~375**

스크린에는 정적 속성과 동적 속성이 존재한다  
동적 속성을 이용해 값을 실시간으로 변경할 수 있다.  

### Dynamic Attributes
- Screen Sys Table이 존재함.
    - 스크린 표시를 위한 시스템 값이 작성된 테이블임
    - 이 테이블은 PBO 실행 직전에 각 스크린 sys table에 저장됨.

- 스크린에는 GROUP 1~4가 존재함  

    각기 스크린 엘리먼트의 속성을 그룹으로 지정하여 관리할 수 있음.  

    1. Screen element의  MOD.Group 그룹탭에서      
    ![Screen_SYS_table_Mod](../screenShot/WEEK3/Screen_SYS_table_Mod.png)  
    2. 혹은 스크린 페인터에 엘리먼트 속성의 그룹 입력창에서 입력하거나하면된다.  
    ![Screen_Painter_Group_check](../screenShot/WEEK3/Screen_Painter_Group_check.png)  

---

### **Creation of PUSH Button**

Button을 활용할때에는 Button을 클릭할때 변동되는 값을 저장할 **변수**와  
그 변수를 받아와 실행할 **Function**이 필요하다.

Function은  
Function CODE라는 식별자를 가지게 되고,  

FCT Code라는 칸에 CODE명을 최대 char20까지 작성할 수 있다.  
이때 변동되는 값은 시스템 변수인 SY-UCOMM (시스템 유저 커맨드)에 저장되는데, 
OK_code라는 이름으로 Screen Element List와 TOP(타입풀)에 저장하여 활용한다.

```abap
    ok_code TYPE sy-ucomm.  
```
![OK_CODE](../screenShot/WEEK3/IMPORTANT_ok_CODE.png)

#### 푸시 버튼의 흐름

1. 버튼의 선택여부를 식별할 FCT Code를 생성  
    FCT code를 식별자로 선택여부를 확인함.  
    코드이름을 MODI로 생성했음  
2. 이 코드 값은 엘리먼트 리스트에  
    ok_code를 생성하여 MODI 값을 받을 것으로   
    스크린 페인터에 선언  
3. 아밥 코드인 TOP에 OK_code를 같은이름으로 변수 선언하여  
    이름을 통한 아이디피케아션을 완성함.  

TOP에  
`gv_mod     TYPE i. " Display/Change 버튼의 값을 처리하기 위한 변수   `  
PBO에   
` MODULE modify_screen.` 생성  
PAI에   
 ` MODULE user_command_0100.에 case ok_code.` 를 추가함.  


## Designing Screen Sequence
**&nbsp;&nbsp; B4.P376~380**

PAI에서 입력된 값에 따라 다음으로 실행할 스크린을 선택한다면,  
동적인 스크린의 접근이 가능하다.

### STATIC SCREEN SEQUENCE
 
Screen Attribute에서 NEXT dynpro에 값을 입력하면   
어떤 유저액션이 오든지 해당 스크린 PAI이후에  
NEXT dynpro에 입력된 스크린이 실행됨.

> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;실습  
>200번 스크린 생성 NEXT dynpro를 0으로 설정.   
>100번 스크린의 NEXT dynpro를 200으로 설정.  
>100번 스크린이 끝나면 200으로 이동하고 200이 끝나면 100으로 돌아옴.  


### Dynamic screen sequence

만약 100스크린에서 NEXT dynpro가 200으로 설정되었음에도  
모듈의 소스코드에 SET Screen 과 leave screen.이 작성되었다면. 

- 예시 
  ```abap
    Module ...
        set screen 300.
        leave screen.
        * 코드 압축방법
        leave to screen 300.
    endmodule.
  ```

정적으로 작성한 NEXT dynpro인 200 스크린이     
아니라 PAI안에 작성된 `leave to screen 300.`에 따라서   
300번 스크린으로 이동함.

### Insert screen sequence

-   Screen 안에 screen 순서를 집어넣는 것,  
100에서 300, 300에서 301이후 301이 완료되면 다시100으로 돌아오기.  

-   CALL SCREEN 구문을 사용한다.  
이후 내부 스크린 그룹의 마지막 스크린에서  
- leave to screen 0 하면  
원래 스크린인 100번 스크린의 로직이 실행됨.  

### Cusor position
`set cusor field '필드명' [offset <포지션명>]`  
PBO에 모듈 설치해서 작성해놓으면  
커서가 해당위치에 놓인 상태로 Display됨.

## CALLING DIALOG BOX.
**&nbsp;&nbsp; B4.p381**  
- 스크린을 생성할때 Modal Dialog Box로 선택하여 생성할 수 있다.    
좌상단 좌표와 우하단 좌표를 설정해서 popup 위치를 설정할 수 있다.

- Modal Dialog Box를 부를때는 popup이기 때문에  
CALL SCREEN 을 통해 불러야한다.
> <u>Leave to screen이 아니다.</u>

- 만약 CALL SCREEN이 아닌 LEAVE TO SCREEN 으로 지정한다면,  
팝업창을 닫으면 복귀해야하는 스크린까지 종료된다.
```abap
    CALL SCREEN 101
        STARTING AT lc ur
        *       lc = LEFT COLUMN ; 
                좌측부터의 위치 단위는 Column

        *       UR = UPPER ROW ; 
                위에서부터 위치 단위는 ROW(Line)
        *이하 옵션
        ENDING   AT RC LR
```

실습 Dialog Box 스크린 150생성   
Dialog Box 크기 조절방법

---
<b>Exercise 26 B4.P383</b>

---

## SAPMZQUIZ_E01_10.ABAP

1. **Display할 내용을 GS_로 생성.**

    - custtype필드는 short description으로 보여주기 위해서  
      DE를 생성하거나 적당한 DE를 Dicc에서 찾아서 쓸 수 있다.    
    - Discount또한 NUMC가 아닌 Decimal로 설정한다.
      이때도 Domain을 만들거나, Dicc에서 찾아서 쓴다.     
    - DE의 필드 라벨은 ABAP Dicc에 저장되므로     
      이를 이용해서 Selection text를 사용하는 것으로 알 수 있다.  
<br>

2. **연락처의 경우 Tel 혹은 Email중 한가지 종류를 불러와야한다.**  
    - Contact 필드를 만들어라  
    - 연락처를 불러올때 조건문을 넣어  
        - Tel이 있으면 tel을 조회하고  
        - tel이 없으면 email을 조회하고  
        - 둘다 없으면 공란으로.  
    ```abap
        if sydn_conn-telephone is not initial.
            move sycn_conn-telephone to wa_scustom-connetction.
        elseif sydn_conn-email is not initial.
            move sycn_conn-email to wa_scustom-connetction.
        else.
            move sycn_conn-telephone to wa_scustom-connetction.
    ```
<br>

3. **스크린을 생성한다.**  
    1. 레이아웃 부터 정의한다.    
        1. get from Dicc으로 위에 만든 스트럭쳐 땡겨옴.  
        2. 원하는 위치로 레이아웃 배치 및 Label text 수정  
    2. 각 Input Field 필요한 Group 명 설정   
        - 계속 입력 가능한 CUst_number를 제외한 Field들 그룹설정함.  
    3. 스크린 엘리먼트에 OK_code 선언.  

<br>

4. **TOP Include에서 변수선언**  
    1. 레이아웃에서 사용한 스트럭쳐를 Tables로 생성  
    2. User Command 변경사항 접수를 위해 OK_CODE TYPE: SY-ucomm으로 생성  
    3. Work Area생성.  
<br>

5. **{PBO, PAI, FUNCTION} INCLUDE 생성**  
<br>

6. **기본 Screen의 FLow Losic 기본 Module 활성화.**    
    - **PBO MODULE**  
        - status Module.  
            - Title bar : 타이틀 작성하고 Active    
            - Status bar :   
                1. Standard Tool bar에 필요한 Function code 선언  
                2. Function List에   
                    1. Function Code 선언  
                    2. Icon 선택 및 Icnon text 선언  
                3. Application tool bar에 Fct 입력  
        - Clear_okcode :    
            실행 완료한 USER Command 초기화.  

    - **PAI Module**  

    - user Command Module.  

        - Function List에 작성한 FCT 코드 작성  

        - 각 FCT코드에 맞는 Prg진행 및 SubRoutine 또는 call 생성.  

            - Subroutine 및 Fucntion은 Function Include에 생성.  
    - Call_data Module

        - 입력 조건인 ID를 Where절로 Scustom에서 Data를 가져오는 SELECT문 작성.
<br><br>

7. **GET_DOMAIN_VALUES Function을 INCL에 Subroutine으로 선언**

    - Function이 어떻게 구성되는지 잘 모를때에는 Text Function으로 필요한 입력값과 출력 DATA TYPE을 확인해보자.

    - GET_DOMAIN_VALUES의 경우에는 Export할 도메인 명을 상수로 입력해주고

    - Import된 Shorts Description과 조건을 받안 놓을 Internal Table을 지역 변수로 선언

    - Key Access를 사용하여 Export된 Itab에서 필요한 값을 추출한다.

    ```abap
        READ TABLE LT_values INTO ls_value 
            WITH KEY domvalue_l = wa_scustom-custtype. 
        IF sy-subrc = 0.
        wa_scustom-custtype = ls_value-ddtext.
        ENDIF.
    ```

8. **연락처 조건 SubRoutine 작성**
    ```abap
        IF scustom-telephone IS NOT INITIAL.
            ZSCUSTOMINFO_E01-CONTACT = scustom-telephone.

        ELSEIF scustom-EMAIL IS NOT INITIAL.
            ZSCUSTOMINFO_E01-CONTACT = scustom-EMAIL.
        ENDIF.
    ```
9. **DB DATA Transfer Module선언**  
    7번 8번 서브루틴과 CAll_data Midule의 내용을 Display하는   
    MOVE-COREESPONDING 서브루틴을 작성해서 PBO에 모듈로 생성.  
<br>

10. **Screen Modify를 위한 PBO Module 선언**  
    변경 조건인 Screen 그룹명을 조건으로 Screen-input 조건을 변경하는 LOOP문 작성  
    ```abap
        FORM changing .
            LOOP AT SCREEN .
                IF screen-group1 ='INF'.
                    screen-input = gv_mod. 
                ENDIF.
                MODIFY SCREEN.
            ENDLOOP.
        ENDFORM.
    ```
11. **단위 설정**  
    단위에 따른 변경사항은 해당 필드의 Additional Keyword로 참조할 
    ```abap
        LOOP AT gt_sbook INTO gs_sbook.

            WRITE: /gs_sbook-carrid,
                    gs_sbook-connid,
                    gs_sbook-fldate,
                    gs_sbook-bookid,
                    gs_sbook-customid,
                    gs_sbook-custtype,
                    gs_sbook-smoker,
                    gs_sbook-luggweight unit gs_sbook-wunit,
                    gs_sbook-class,
                    gs_sbook-forcuram,
                    gs_sbook-forcurkey,
                    gs_sbook-loccuram currency gs_sbook-loccurkey,
                    gs_sbook-order_date.
        ENDLOOP.
    ```
<br>

12. **Screen Prg에서 Report Prg 호출**  

    **[프로그램 호출 정리내용](../week2/SAP_TAW10_UNIT14-15.md)**  

    - 본 문제에서는 Insert Program 방식을 요청하고 있다.    
        따라서 Main Prg로부터 Inserted Prg에    

        - Input 내용을 SAP Memory로 받을 수 있도록 코드 작성한다.    

        - report prg에서 Get parameter를 작성한다.  
<br>

13. **Search Help**  
    Screen Element에 직접 Search Help를 설정하는 방식은 추천하지 않는다.

    도메인 혹은 DE에 Search Help를 입력하여,  
    해당 Component를 사용하는 모든 프로그램에서 사용할 수 있도록한다.

14. **Count 찾기**
    1. COUNT 획득 방법 1  
      SYS변수를 이용해 SELECT 횟수를 가져오기.  
      gv_count = sy-dbcnt.  
    2. COUNT 획득 방법 2  
      gv_count = lines( gt_sbook ).  
    3. COUNT 획득 방법 3  
      DESCRIBE TABLE gt_sbook LINES gv_count.  

---

## Screen Elements for output
**&nbsp;&nbsp; B4.p422**

### Text Field  
**&nbsp;&nbsp; B4.p423**  
    
- 정적 Text를 화면에 표시하고자 할때 사용하는 오브젝트  
    Start Position, BOLD 등 설정이 가능함  
     EX) Right-justified  
- 레이아웃 에디터에서 Input Field등을 Dicc에서 불러올때    
    불러올 Text label의 길이를 선택할 수 있다.  

### STATUS Icon
**&nbsp;&nbsp; B4.p424**
-   스테이터스 아이콘을 생성할때는 이름과 길이 데이터 포맷이 필수적이고,  
레이아웃에디터에서 생성하고 top에 똑같은 이름으로 선언해줘야한다.  
-   `data : iconfield1 TYPE icons-text.`  
-   이후 PB모듈에서 SET_ICON. 모듈을 생성하고
'ICON_CREATE' 스탠다드 펑션을 호출하여 ICON 변경사항을 EXPORT ,IMPORT한다.

- 예시
sapmzscreen_e01
1. 레이아웃에 아이콘 생성
    - 좌측 팔렛트 최하단이 아이콘임
    - 아이콘 생성하고 비저블 길이 와 이름을 설정
2. TOP에 아이콘 선언
3. Display될 스크린의 PBO에 모듈 생성
4. 해당 모듈에 call FUNCTION 'icon_create'
    - 필수 값
        - Exporting  
            NAME : 불러올 아이콘 이름
        - IMPORTING  
            RESULT :가져온 아이콘을 넣을 프로그램의 변수.

---
### Group Box
- 여러필드들을 화면상에 보기 좋게 표시하는 것
1. 마찬가지로 스크린 레이아웃에서 먼저 그룹박스를 생성하고
    - NAME을 통해 식별하는데 입력안해도 자동 설정
    - TEXT 에 Display될 Title을 작성함
2. 그룹으로 묶을 필드를 그룹 박스 내부에 배치.
3. Group Box는 그냥 보기좋게 하기만 하는 것이라  
    동적 활용을 하지는 않음.

---
## INPUT/ OUTPUT Fields
**&nbsp;&nbsp; B4.p430**
- 말그대로 인풋과 아웃풋이 가능한 필드임
- 인풋 체크가 가능함
    1. Data Type Check
        Char를 입력해야하나 I가 오면 안됌. 

    2. Data Consistency Check
        1. ABAP DIcc Reffernce Check
        2. FK Check
        3. Domain Value Check

    3. 서치헬프
    - 드롭 다운형식으로 제작할 수 있음..
    - 메모리 ID 및 SET, GET 속성적용이 가능함.
    - Leading zero 설정은
        수형식 앞의 0을 표시할 것인지 선택문.

1. ABAP DIcc에서 가져올때
    1. 스트럭쳐의 컴포넌트를 이용해 불러오기
    2. TOP에 TABLE : 'DB table이름'.  " DB 컴포넌트 사용을 선언함  
<br>

2. 레이아웃에서 직접 설정할 때  
    1. 레이아웃에서 필드를 생성.  
        - 이름 등 필수 값입력
    2. TOP에 변수를 이름과 설정을 똑같이 생성함.
<br>

3. TOP에 먼저 변수를 생성하고  
    레이아웃에서 F6 - GET FROM PROGAM 기능을 사용해서     
    프로그램에서 생성한 변수를 레이아웃에 생성 편집이 가능하다.  

---
### DropDown Field
**&nbsp;&nbsp; B4.p432**

-   Input Field의 General Attribute에서 드롭다운 선택창을 LISTBOX로 선택한다면    
해당 필드에 서치핼프가 드롭다운 리스트로 보여진다.  

-   만약 리스트가 너무 많은 것에 사용한다면 드롭박스가 의미없다  
    10건 내외일 때 사용하는 것이 의미있다.    

- KEY 값을 함께 Display 하고자할 때는 lIst box with Key 설정을 선택한다.


---
### CHECK BOX & RADIO BUTTON
**&nbsp;&nbsp; B4.p434**  
-   체크박스와 라디오버튼은 유저의 선택이라는 액션이 발생하기에
    이 액션의 변동값을 저장하고 진행시킬 FCT code가 필요하다.
    
- 체크 박스 선택과 라디오버튼 선택또한 User Command 이기때문에
    기본적으로 선택 이후 Screen Flow logic이 돌아감.

#### CHECK BOX
    Optional & Multiple  
1. 레이아웃 에디터에서  생성가능  
    - NAME, Text, Data Format 필수 입력 필요  
        DATA Format은 Char1  
    - FCT code는 무조건 입력해야함.  
2. TOP 에서 똑같은 이름으로 생성  
    `data : check(1) type c.`  
    기본 선택으로 설정해놓고 싶다면 `VALUE 'X'`로 생성


#### RADIO BUTTON
    Only One can be chosen  
1. 체크 박스와 유사  
2. Defalut 값으로 선택할 것을 꼭  `VALUE 'X'`로 미리 선언해 놓아야함.  
3. 라디오버튼은 그룹으로 묶어야함.  
    - 필요한 묶음을 다중 선택하고  
    - 마우스 우클릭으로 Radio Button - group - Define.  
    - FCT 코드 입력하면 같은 그룹의 라디오 버튼은 자동 입력된다.  
4. 라디오 버튼은 한개 묶음이기때문에    
    한개 라디오 버튼 그룹은 FCT CODE가 동일함.    
    **&nbsp;&nbsp; B4.p438**  

---
<b>Exercise 28 B4.P439</b>

---

<b>ZQUIZ_e01_12 연습 문제</b>

---


**&nbsp;&nbsp; B4.P340**  
시험에서 사용하는 DB ERD같음 확인 필요함.