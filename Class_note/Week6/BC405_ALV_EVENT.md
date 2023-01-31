# ALV Events And Methods
![Architecture](../screenShot/Week6/ALV_Control_archtecture.jpg)

## Handling Events
&nbsp;&nbsp;&nbsp;&nbsp;**B.BC405P.203**   

에휴 저게 뭔소리야
어떠한 이벤트가 발생하면 어느 이벤트 핸들러로 처리할 것인지 메쏘드를등록을 해놓아야 한다.

ALV 그리드에 존재하는 대표적인 이벤트는
|EVENT NAME| 설명 |
|:---:|---|
|DOUBLE_click|더블 클릭시|
|print_top_of_page|아웃풋 데이터를 프린트(현재 중요 X)|
|TOOLBAR|Standard toolbar에 User가 원하는 기능을 추가할 수 있음.|
|USER_COMMAND|USER-Defined Function을 실행할 때 처리|

...이외에도 상당히 많음.

이벤트 핸들러는 클래스 오브젝트로 생성하여 관리됨.

```ABAP
    CLASS <class_name> DEFINITION.
        PUBLOC SECTION     " 대체적으로 퍼블릭
            [CLASS-]METHODS :
                <method_name> FOR EVENT <event_name> OF <class_name>
                    IMPORTING <para_1> ... <para_n> [SENDER].
                <method_name2> ...
    ENDCLASS.

    CLASS <class_name> IMPLEMETATION.
        METHOD <method_name>.
        ...                     " 메쏘드 입력
        ENDMETHOD.
    ENDCLASS.
```

주요 사용 정보들 

Double_click 혹은 HOTSPOT_CLICK 시에는 아래 파라미터를 이용해 정보를 받는다.  
ES_ROW_NO : RECORD의 ROW정보가 담긴 STRUCTURE  
E_column : RECORD의 FIELD 정보가 담긴 STRUCTURE  

- 예시 구문
```ABAP
    data : go_alv_grid type ref to CL_gui_alv_frid.

    class lcl_event_handler DEFINITION.             " 클래스 정의부
        PUBLIC SECTION.
            CLASS-METHODS : on_double_click
                for EVENT double_click
                of cl_gui)alv_grid
                IMPORTIG es_row_no e_column.
        ```
    ENDCLASS

```

### EVENT HANDLER의 사용 등록
클래스 정의와 임플리먼트를 했으면
이벤트핸들러를 해당 프로그램에서 사용할 수 있도록 등록해주는 작업이 필요하다.
ALV-GRID 데이터 호출 METHOD 이전에 선언해줘야함.

```abap
    SET HANDLER lcl_event_handler=>on_double_click
                for go_alv_grid.
```


## HANDLING ADDITIONAL EVENTS
&nbsp;&nbsp;&nbsp;&nbsp;**B.BC405P.216**   
### TOOLBAR EVENT


MT_TOOLBAR 라는 ITAB에 툴바 의 펑션 내용이 존재함.

LS_BUTTON TYPE STB_BUTTON.를 사용해 
toolbar 메쏘드를 사용함.

| Parameter |상세|
|---|---|
|LS_BUTTON-FUNCtion |FNC CODE|
|LS_BUTTON-icon |아이콘|
|LS_BUTTON-Qickinfo |팝업 설명창|
|LS_BUTTON-Butn_Type |팝업 설명창|
|LS_BUTTON-Disabled||
|LS_BUTTON-Text||
|LS_BUTTON-Checked| |

|Button TYPE | 기능|
|---|---|
|0| Normal|
|1| Menu_ And Std.Button |
|2| Menu |
|3| Separator |
|4| Selection Buttom |
|5| Checkbox Button |
|6| Menu Entry |

LS_BUTTON을 메쏘드 상에서 위의 정보를 전달하고

`INSERT ls_button into table e_object->mt_toolbar.`
위의 인서트문을 사용해 툴바에 해당 정보를 삽입함.

결과적으로 툴바에 생성하는 CUSTOM menu는 클래스로 존재함.


## CALLING ADDITIONAL METHOD
## IMPLENT CONTEXT MENU