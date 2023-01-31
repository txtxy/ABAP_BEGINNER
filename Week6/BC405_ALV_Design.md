## ALV Design

## Layout Varient in ALV Grid
&nbsp;&nbsp;&nbsp;&nbsp;**B.BC405P.143**   
1. ALV의 Variant는 리스트 정렬 상태의 분류 및 저장기능이다.
2. 해당 기능은 ALV에 내장된 DISVARINT 전역 변수를 선언하여 활용한다.
3. Variant 기능을 리스트별로 요청에 따라 설정하면 실질 사용은 End-user의 판단이다.
- **MRM 에서 개인 컬럼 정렬 저장과 같은 기능임.**   

- ALV_Grid 클래스의 (SET_TABLE_FOR_FIRST_DISPLAY) Method에 인자를 추가하여 사용한다.

- 사용 인자는 IS_vriant 와 I_SAVE

||IS_VARIANT|I_SAVE|
|---|:---:|:---:|
|Change(Default)|space|space|
|change and <br>select existing|\<st_name\>|space|
|only user-related|\<st_name\>|'U'|
|only Cross-user|\<st_name\>|'X'|
|both over 2|\<st_name\>|'A'|
||DATA \<st_name\> TYPE DISVARIANT.||
- SAVE 인자에 해당하는 값을 할당해서 VARIANT의 설정에 제한을 줄 수 있다.

---
### 예시 코드
P145 배껴오기
```abap
    *save와 Variants 변수 선언
    Data : gs_variant TYPE disvariant,
           gv_save    TYPE c LENGTH 1.

    * Variant 변수 값 할당
    * METHOD 호출 이전에 할당

    gs_variant-report = sy-cprog.
    gs_variant-variant = pa_vari.   " Selection-screen에서 활용시

    * Variant 활용 선언
    * IN PBO

    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
        i_structure_name              = 'SBOOK' 
        is_variant                    = gs_variant
        i_save                        = 'A'
        ...
```

### Selection Screen에서 Variant 사용하기

1. Parameter TYPE을 disvariant-variant.로 생성
2. 1번에서 선언한 Parameter로 입력된 값을
3. gs_variant-variant의 값으로 부여
4. Grid Method에 IS_VARIANT 값을 GS_variant로 설정하여 활용.
- PARAMETER로 입력한 레이아웃으로 Display됨.

---
## Changing Layout in ALV Grid

- lvc_s_layo는 ALV 레이아수을 관리하는 스트럭쳐 전역 변수임.
- 해당 TYPE으로 변수를 선언해서 ALV의 레이아웃을 관리함.
- set_table... ㅡ Method is_layout 인자에 해당 변수를 할당하여 활용.
- 예시 코드
    ```ABAP
        DATA : gs_layout TYPE lvc_s_layo.

        gs_layout-grid_title = 'Booking List Data'. "스탠다드 메뉴바와 어플리케이션 툴바사이의 제목
        gs_layout-zebra = 'X'.          " ROW마다 색다르게
        gs_layout-cwidth_opt = 'X'.     " 열 간격 자동정렬
        gs_layout-no_toolbar = 'X'.    " standard toolbar를 가림
        gs_layout-no_headers = 'X'.    " 리스트 컬럼 헤드를 가림
        gs_layout-sel_mode = 'D'.       " 선택 모드 변경하기 A,B,C,D가 각기 올 수 있음
        gs_layout-excp_fname = 'EXCP'.  " 신호등 아이콘 필드네임 전달
        gs_layout-excp_led = 'X'.

        CALL METHOD go_alv->set_table_for_first_display
            EXPORTING
                i_structure_name              = 'SBOOK' 
                is_variant                    = gs_variant
                i_save                        = 'A'
                is_layout                     = gs_layout
            ...
    ```

---
### Layout 주요 활용 인자 (TYPE lvc_s_layo)

|Parameter|설명|
|---|---|
|grid_title | 어플리케이션 툴바와 ALV 리스트 데이터 사이의 제목<br>'TEXT' 혹은 TEXT ELEMENT가 올 수 있음.<br>최대 70자리까지 가능함,|
|zebra(char1) | 행마다 색을 다르게 할 것인지|
|cwidth_opt(char1) | 열간격 자동 맞춤|
|no_headers | Column name 을 보여줄 것인지?|
|sel_mode | SELECTION MODES<br>얼마나 많은 셀, 컬럼, 라인을 선택할 수 있는지 설정|
|no_toolbar | standard toolbar를 보여줄 것인지?  |
|totals_bef | 합계를 상위 로우에 보여줄 것인지?  |
|info_fname | 특정 ROW를 색으로 칠하기.|
|ctab_fname | 특정 CELL의 색상을 지정하는 것?|
|excp_fname = 'LIGHT' | 신호등 아이콘 생성 기능 <br>해당 테이블 WA에 light컬럼이 생성됨 1 은 빨강 2는 노랑 3은 초록|
|excp_led = 'X' | 신호등이 말고 빨초노 삼색 경고등이 생성|

  
    
---  
  
### sel_mode에 올 수 있는 값
|값|가능한 기능|로우 SELECTION-COLUMN|
|---|---|---|
| NULL | 'B'와 동일|ROW 선택 불가|
| A | 멀티플 컬럼 /멀티플 로우 |ROW 선택 가능|
| B | 멀티플 컬럼 /로우 1개    |ROW 선택 불가|
| C | 멀티플 컬럼 /멀티플 로우 |ROW 선택 불가|
| D | 멀티플 컬럼 /멀티플 로우 <br>어느 셀이든 선택 |ROW 선택 가능|

### excp_fname으로 아이콘으로 표시하는 방법

1. types : excp TYPE char1 생성
2. it_outtab Parameter의 argument로 1번의 인자를 포함시킴
3. 반복문과 조건문을 이용하여 `gs_data-excp = '1'.`와 같이 ROW마다 값을 할당함. 

- 예시 코드
```abap

    LOOP AT gt_book into gs_book.

        " orderdate - fldate가 50미만일 시
        if ( gs_book-fldate - gs_book-ORDER_DATE ) < 50.  

            " 빨간색으로
            gs_book-excp = '1'.                                       

        " orderdate - fldate가 50이상 100미만일 시
        elseif ( gs_book-fldate - gs_book-ORDER_DATE ) >= 50 and
             ( gs_book-fldate - gs_book-ORDER_DATE ) < 100.       

            gs_book-excp = '2'.                                       
            " 노란색으로
    
        else.

            gs_book-excp = '3'.                                        
            " 이외 값은 초록색으로

        endif.

        modify gt_book FROM gs_book.     
                                    
    ENDLOOP.
```

---
## USING SORT CRITERIA IN AVL-GRID

    lvc_t_sort 와 lvc_s_sort 두개의 시스템 테이블과 스트럭쳐를 이용.
    SORT 를 위한 값을 저장하고 활용함.

    SORT를 위한 시스템 변수를 TOP등에서 전역변수로 선언해서 활용함.

    필드별로 ASC, DESC 를 선택적으로 적용할 수 있고,
    SORT 순서를 임의로 지정해야한다.
    set_table... ㅡ Method it_sort 인자에 변수를 할당하여 ALV에 적용한다.

- 예시 코드
```abap
    DATA: ls_sort TYPE lvc_s_sort.

    ls_sort-fieldname = 'CARRID'.          " SOTING 할 필드 이름
    ls_sort-up        = 'X'.               " ASC로 할 것인지?
    ls_sort-DOWN      = ''.                " DESC로 할 것인지?
    ls_sort-spos      = 1.                 " SORTING 순서는?
    APPEND ls_sort to gt_sort.
    clear ls_sort.
```

---
## Adapting the Appearance of the ALV-Grid
&nbsp;&nbsp;&nbsp;&nbsp;**B.BC405P.158**   

### ROW COLOR CONTROL

출력을 원하는 ALV-Grrid table에 COLOR라는 Field 를 활용
layout에 INFO_FNAME 인자에 컬러 컴포넌트의 필드이름을 전달해줘야한다.

첫번째 자리는 무조건 C로 시작함

색의 번호는 0~7개만 있음
즉 사용가능한 색은 8개밖에안됨.

색에 따른 상수와 의미는 정해져있음
- 색 지정 예시  
`gs_sbook-color = 'C610'. `
`gs_sbook-color = 'C`

|C|0 ~ 7|0/1|0/1|
|:---:|:---:|:---:|:---:|
|선언부|색번호|Intensified|Inverse|
|컬러임을 선언|색 번호|BOLD인지?<br>Inverse와 동시 불가|foreground 색을<br> 변경할 것인지?|


|No.|NAME|Color|
|---|---|---|
|0|COL_BACKGROUND |GUI-dependent |
|1|COL_HEADING | Gray-blue |
|2|COL_NORMAL | Light gray |
|3|COL_TOTAL | Yellow |
|4|COL_KEY | Blue-green |
|5|COL_POSITIVE | Green |
|6|COL_NEGATIVE | Red |
|7|COL_GROUP | Purple |

---
### CELL COLOR CONTROL
    특정 CELL에 COLOR 표시

DATA 를 가지고 있는 중심 TABLE에    
IT_COLFIELDS라는 이름으로 DEEP STRUCTURE를 이용해야 한다.

TYPE은 lvc_T_scol 타입을 사용한다.

IT_COLFIELDS는 NESTED STRUCTURE인 ROW로 이루어 져있고  

각 RECORD는 {Field_name / COLOR(COL / INT / INV) }로 이루어져 있다.

반복문을 통해 DATA RECORD 마다 COL과 관련된 색 변환 조건을 부여한다.

LAYOUT 스트럭쳐의 ctab_fname에 위의 lvc_T_scol 타입을 사용하는 변수를 전달한다.

```abap
    LOOP AT gt_data INTO gs_data.    

        IF gs_data-invoice = 'X'.

            gs_scol-fname = 'INVOICE'.
            gs_scol-color-col = '3'.
            gs_scol-color-int = 1 .
            gs_scol-color-inv = 0 .

            APPEND gs_scol TO gs_data-itab_scol.

        ENDIF.
        
        MODIFY gt_data FROM gs_data .
        CLEAR : gs_data,gs_scol.
  ENDLOOP.
```


### STANDARD FUNCTION을 숨기기

![](../screenShot/Week6/GUI_ALV_GRID_UI_FUNCTION_attribute.png)

UI 관련 속성은 CL_ALV_GIRD안에 **MC_FC_** 혹은 **MC_MB**로 시작한다

Attribute TAB안에 LEVEL은 CONSTANT이고
TYPE은 UI_FUNC로 되어 있어서 찾을 수 있다.

CL_GUI_ALV_GRID의 인자명은 **it_toolbar_excluding**


## ALV-Grid의 Field Catalog


ALV를 통헤 Display하는 Internal Table의 Fields 속성값에  
임의로 지정하는 것이 Field Catalog를 이용하는 것 

LVC_T_FCAT SYS VAL를 사용함

- 언제 사용하느냐?

    1. 필드명을 다르게한다거나

    2. Grid로 보여질 전역 변수 테이블에 특정 필드를 추가할 때.
    3. 여러 테이블의 내용을 한개 Grid에 혼합해서 Display할 때.

- 어떻게 만드느냐?

    1. ABAP Dicc의 내용을 그대로 참조해서 Catalog에 적용하는 방식  
        - 실체 이름인 Filename, 참조변수의 Culomn과 테이블 REF_FIELD, REF_TABLE.
        - 만약 ITAB과 DB table의 Fname이 동일하다면 REF_FIELD는 생략 가능함.
        - 예시 코드
        ```abap
            ls_fcat-fieldname ='PHONE'.
            ls_fcat-ref_table = 'SCUSTOM'.
            APPEND ls_fcat TO gt_fcat.
            CLEAR :ls_fcat.
        ```
    2. ABAP Dicc의 내용과 함께 추가적인 Property를 적용하는 방식
        - 1번 방법에 몇가지 설정을 추가하는 방식으로 이해하면 됨.
        - 예시 코드
        ```abap
            ls_fcat-fieldname ='PHONE'.
            ls_fcat-ref_table = 'SCUSTOM'.
            ls_fcat-ref_field = 'TELEPHONE'.
            ls_fcat-col_pos = 8.
            APPEND ls_fcat TO gt_fcat.
            CLEAR :ls_fcat.
        ```
    3. ABAP Dicc의 내용을 참조하지 않는 방법. 
        - Field Catalog에서 전부 속성을 작성하는 방식
        - 귀찮지만 완전히 새롭게 작성할 수 있는 장점.
        - 예시 코드
        ```abap
            DATA : ls_fcat LIKE LINE OF gt_fcat.

                ls_fcat-fieldname = 'CARRID'.
                ls_fcat-coltext = 'Airline'.
                APPEND ls_fcat to gt_fcat.
                CLEAR : ls_fcat.
                
                ls_fcat-fieldname = 'CONNID'.
                ls_fcat-coltext = 'Connection No.'.
                APPEND ls_fcat to gt_fcat.
                CLEAR : ls_fcat.
                ...
        ```


---
### Dicc Referance 없이 Culomn만들기
- RollName
- INTlen
- DD_OUTLEN
- inttype


---
### Formatting Unit 이용하기

화폐 혹은 물리단위의 경우   
Cfieldname을 통해 output Formatting의 레퍼런스 체크를 실시

- cfieldname : 화폐정보가 담긴 필드이름
- currency : 화폐단위가 출력될 컬럼

- qfieldname : 단위 정보가 담긴 필드이름
- quantity   : 단위가 출력될 컬럼


---
### OUTPUT PROPERTY
|Property|설명|
|:---:|:---|
|CHECK | 체크박스로 표시할 지?  |
|COL_POS | 컬럼의 순서를 지정 |
|DO_SUM | Total sum을 표시할 컬럼인지?  |
|HOT SPOT | 해당 데이터에 밑줄 긋기  |
|NO_SUM | 집계함수에 포함하지않기  |
|EMPHASIZE | 컬럼의 색을 지정해서 강조하기  |
|KEY | 키컬럼인지?  |
|LOWERCASE | 대소문자 구분하는지?  |
|NO_OUT | 해당 컬럼 숨김처리  |
|OUTPULEN | 컬럼의 길이는 얼마인지?<br>lAYOUT의 컬럼 길이 최적화에 진다.  |
|TECH | 기술적 컬럼인지?<br>단순히 기술적으올 사용되는 컬럼이기에 사용자에게 보이지 않는다.|

--- 
### FORMATTING PROPERTY
|Property|설명|
|:---:|:---|
|DECIMALS_O | 소수점 몇자리까지?|
|DECIMALFIELD | 소수점이 있는 필드이름  |
|ICON  | ABAP 아이콘으로 처리할 필드|
|EDIT_MASK | 마스킹 처리|
|SYMBOL  | 뮤메 Symbol을 이용할 필드|
|LZERO  | 앞자리에 0을 표시할것인지?(NUMC)|
|JUST  | ' ','L','R','C' 정렬  |
|NO_ZERO | 0 표시하지 않기  |
|ROUND | 반올림  |
|ROUNDFIELD | 반올림을 몇자리에서 할것인지 알려주는 필드  |
|NO_SIGN | +- 기호를 보이지 않게  |
  
---
### TEXT PROPERTY  
|Property|설명|
|:---:|:---|
| COLDDICTXT | 컬럼 영역에 따라 적절한 설명문을 가져오기.  |
| SCRTEXT_S  | DE의 SHORT_VALUE의 짧은 설명문을 가져오기  |
| SCRTEXT_M  | DE의 SHORT_VALUE의 Medium 설명문을 가져오기  |
| SCRTEXT_L  | DE의 SHORT_VALUE의 Long 설명문을 가져오기  |
| TOOLTIP | 마우스 오버레이시 설명문 표시하기|
  

---
그렇다면 ZQUIZ_E01_13을 DICC 전역변수를 만들지 말고   
로컬 스트럭쳐를 만들어서     
필드카탈로그를 이용해서 표시해봐라    
ZQUIZ_E01_13_01 이 프로그램을 확인해보면,  
필드카탈로그를 활용하는 방식을 알 수 있다.  

서브루틴 혹은 매크로 혹은 필드 심벌을 이용해서   
위의 예시와 달리 간단하게 만들 수 있는 방법도 있따.

---