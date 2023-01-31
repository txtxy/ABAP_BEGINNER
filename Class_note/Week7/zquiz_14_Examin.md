# 기본 사항 작성

## Incl 생성
1. TOP
2. CLS
3. O01
4. I01
5. F01

## 요청 사항 정리

1. 사용 Table 확인
2. ALV 이벤트 핸들러 Method 체크
    1. Hotspot_click
    2. ALV Toolbar
    3. User_command
3. 필요 스크린 사항   
    modal Dialog screen 2개 필요    
    1. Hotspot_click 이후 출력될 customer 정보
    2. 얼리버드 고객 메뉴바 출력 정보

---
## **필요 변수 작성**.

### DATA 변수 생성
1. tables 생성 및 Display할 DATA의 Structure를 ABAP_Dicc에 전역 변수로 생성.
    - 기본 Field
        - Quauntity 혹은 Currency Key Ref 선언.
    - 날짜 차이를 표시할 DAYS (DE) TYPE I.
    - 취소 아이콘 표시를 위한 CAN_ICON_FIELD (DE) TYPE ICON_D.
    - 신호등 표시를 위한 EXCP Field (DE) TYPE char1.
    - Line 색 표시를 위한 Color_Filed (DE) TYPE char4.
    - CELL 색 표시를 위한 it_color (ITAB) TYPE LVC_T_SCOL.

2. TOP에 TABLE과 WA 선언

3. SCARR 정보 저장 TAB 생성
    - carrid 및 carrname Field만 필요.
    - TAB 및 WA 생성

4. ok_code 변수 선언.


### PARAMETER 및 S-O 생성

1. SELECTION-SCREEN 생성
    1. 1번 BLOCK parameter로 생성 (OBLIGATORY 를 통해 필수 입력 선언.)
    2. 2번 BLOCK S-O 및 RADIO-BUTTON 생성.

2. TEXT ELEMENT와 TITLE_BAR 작성 및 Active

## INITIALIZATION 선언.
1. INITIALIZATION EVENT를 통해 SCARR 내용 획득
    - 18건 밖에 안되는 소수이기에 ITAB에 저장한 뒤 활용.
    - 필수 정보이기에 INIT EVENT에서 획득.

---
## **START-OF-SELECTION 선언**

## GET MAIN DATA

1. MAIN DATA 획득.
    - SBOOK과 SCUSTOM TABLE INNER JOIN.
    - WHERE절의 PA 및 S-O 기준 선언.
2. MAIN DATA 획득 고급 ( 1개 쿼리를 통해 Radiobutton 조건 만족시키기)
    - RANGE 변수를 활용하여 RADIOBUTTON 에 따른 획득 정보 변경
        - RANGE Variable TYPE itab / sign, option, low, high / S-O와 유사.
    - range 변수 선언 
        ```abap
            rt_can TYPE RANGE OF sbkook-cancelled,
            wa_can LIKE LINE OF rt_can.
        ```
    - range 변수 활용
        ```ABAP
            CASE 'X'.
                WHEN pa_val.
                    wa_can-sign = 'I'.
                    wa_can-option = 'EQ'.
                    wa_can-LOW = ''.
                APPEND WA_CAN TO RT_CAN.
                WHEN pa_can.
                    wa_can-sign = 'I'.
                    wa_can-option = 'EQ'.
                    wa_can-LOW = 'X'.
                APPEND WA_CAN TO RT_CAN.
                WHEN ORHERS.
            ENDCASE.
        ```
    - SELECT 구문 WHERE절에 RT_CAN 추가
        `AND a~cancelled IN rt_can`

### 반복문을 통한 CAlculated DATA 입력
1. LOOP문 생성

2. days 계산 값입력
    1. days = 비행 날짜 - 주문날짜 .
    2. days 값에 따라 EXCP 신호등 출력
        - 조건문을 통해 excp값을 각기 입력
        ```abap
            if gs_data-days <= 50 .
                gs_data-excp = '1'.
            elseif gs_data-days <= 100 and gs_data-days > 50 .
                gs_data-excp = '2'.
            else .
                gs_data-excp = '3'.
            endif.
        ```

3. 취소된 Record에 ICON 출력 및 ROW 색 변경
    ```abap
        if gs_data-cancelled = 'X'.
            gs_data-cancelled = icon_cancel.
            gs_data-color = 'C610'.
        endif.
    ```
4. DAYS 150이상인 값에 CELl 색상 부여.
    1. cell_color 를 위한 WA생성
        - `DATA : WA_COLOR TYPE LVC_S_SCOL.`
    2. DATA 조회에 조건 추가
        ```ABAP
            IF GS_DATA-DAYS >= 150.
                gs_scol-fname = 'DAYS'.
                gs_scol-color-col = '5'.
                gs_scol-color-int = '1' .
                gs_scol-color-inv = '0' .

                APPEND gs_scol TO gs_data-it_color.
            ENDIF.
        ```
5. CARRID 입력
    READ TABLE scarr 
6. 반복문 종료.
    - MODIFY DATA
    - 반복문 내부 WA CLEAR.

---

# **ALV-GRID DISPLAY**

## ALV-GRID 생성준비

1. ALV CONTAINER 및 ALV-GRID 변수 선언
    ```abap
        DATA : go_con TYPE REF TO cl_gui_custom_container,
        go_alv TYPE REF TO cl_gui_alv_grid.
    ```
2. ALV-GRID 레이아웃 수정을 위한 LVC_S_LAYO TYPE 변수 선언
    `DATA gs_layout TYPE lvc_s_layo.`

3. FIELD-Catalog 를 위한 lvc_t_fcat TYPE 변수 선언
    `DATA gt_fcat TYPE lvc_t_fcat.`

4. UI Fuction 기능 구현을 위한 ui_functions TYPE 변수 선언.

5. ALV-GRID를 위한 100 스크린 생성
    1. Custom-container 생성
        - Rsizable check
    2. ok_code Element List에 입력
    3. STATUS 모듈과 USER_COMMAND 모듈 생성.
    4. ESCAPE 모듈 생성 (AT EXIT-COMMAND)

6. MAIN Prg에 CALL SCREEN 100. 구문 추가.

## ALV-GRID 생성
1. 기본 Container 조건문 작성
    - `IF go_con IS INITIAL .`
    - EXPORTING  container_name  = 'MAIN_CON'
2. CREATE OBJECT go_con ALV-GRID 컨테이너 생성
    - `pattern CL_GUI_CONTAINER`
    - exporting container_name = 'MAIN_CON'
 
3. CREATE OBJECT go_alv ALV-GRID 생성
    - `pattern CL_GUI_ALV_GRID`
    - exporting  i_parent = go_con

4. CALL METHOD go_alv->set_table_for_first_display   
    **ALV-GRID로 DATA 전달 및 Display**
    ```abap
        EXPORTING
            is_layout                     = gs_layout
        CHANGING
            it_outtab                     = gt_data           " MAIN DATA를 가진 Table
            it_fieldcatalog               = gt_field_cat      " Field Catalog를 가진 Table
            it_sort                       = gt_sort           " 정렬 정보를 가진 Table
    ```

5. GRID LAYOUT 세팅을 위한 Subroutine 입력
    - first_display Method 이전에 생성
    ```abap
        * 열간격 정렬 체크
        gs_layout-cwidth_opt ='X'.

        * ROW별 구분
        gs_layout-zebra = 'X'.

        * GRID 타이틀 생성
        gs_layout-grid_title = TEXT-001.

        * ROW 색 컬럼명 전달
        gs_layout-info_fname = 'COLOR'.

        * CELL색 컬럼명 전달
        gs_layout-ctab_fname = 'ITAB_SCOL'.

        * EXCP 컬럼명 전달        
        gs_layout-excp_fname = 'EXCP'.
    ```

6. SORT subroutine 생성
    - first_display Method 이전에 생성
    ```abap
        DATA : ls_sort TYPE lvc_s_sort.
               
        ls_sort-fieldname = 'NAME'.
        ls_sort-up        = 'X'.
        ls_sort-spos      = 1.

        APPEND ls_sort TO gt_sort.
        CLEAR ls_sort.
    ```

7. Field Catalog 설정

lvc_fieldcatalig_merge
글로벌 스트럭처 타입을 이용해 필드카탈로그를 생성해주는 펑션

```abap
    DATA : ls_fcat TYPE lvc_s_fcat.   " WA 생성.

      CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
       EXPORTING
         I_STRUCTURE_NAME             = 'ZSQUIZ14_E00'     " 해당 글로벌 스트럭쳐 타입의 필드카탈로그 형식을
        CHANGING
          ct_fieldcat                  = gt_field_cat      " 현재 ALV-GRID의 필드 카탈로그 형식으로 전달.
       EXCEPTIONS
         INCONSISTENT_INTERFACE       = 1
         PROGRAM_ERROR                = 2
         OTHERS                       = 3
                .
      IF sy-subrc <> 0.
    * Implement suitable error handling here
      ENDIF.

    LOOP AT gt_FCAT into ls_fcat.                           " 기타 설정이 필요한 사항은 반복문을 통해 설정
        case ls_fcat-fieldname.
            WHEN 'CUSTOMID'.
                ls_FAT-hotspot = 'X'.
            WHEN 'CANCELLED'.
                ls_FCAT-icon = 'X'.
                ls_FCAT-COLTEXT = 'Cancelled'.
                ls_fcat-col_pos = 15.
        ENDCASE

    modify gt_fcat from ls_fcat.
    endloop.
```
## EVENT HANDLER 설정
1. EVENT HANDLER CLASS 정의
```
    CLASS lcl_event_handler DEFINITION.
      PUBLIC SECTION.
        CLASS-METHODS :

          on_hotspot_click
            FOR EVENT hotspot_click
            OF cl_gui_alv_grid
            IMPORTING
              es_row_no e_column_id,

          on_toolbar
            FOR EVENT toolbar
            OF cl_gui_alv_grid
            IMPORTING 
                e_object,

          on_user_command
            FOR EVENT user_command
            OF cl_gui_alv_grid
            IMPORTING 
                e_ucomm.
    ENDCLASS.
```
2. EVENT HANDLER CLASS 구현
```
    CLASS lcl_event_handler IMPLEMENTATION.                  " 클래스 구현 선언.

      METHOD on_hotspot_click.                               " on_hotspot_click 메쏘드 내용 작성         
        CASE  e_column_id-fieldname.

          WHEN 'CUSTOMID'.
            PERFORM get_select_data USING es_row_no-row_id
                                          sy-subrc.
            IF sy-subrc = 0.
              CALL SCREEN 120
              STARTING AT 10 5.
            ENDIF.

        ENDCASE.
      ENDMETHOD.

    ENDCLASS.
```

# Dialog box 생성

## Hotspot_Click에 사용될 screen 생성
- 기본 STATUS, USER_COMMAND, CLEAR ok_Code 모듈 설치
- Dialog box에 출력할 정보 조회 모듈 설치 
    - gs_data-customid 를 TABLE KEY로 SCUSTOM TABLE 정보 조회
- 메소드 구현
```
      METHOD on_toolbar.                               " TOOLbar 내용 작성      
        DATA : ls_button TYPE stb_button.
    *   구분선 추가.
        ls_button-butn_type = 3.
        APPEND ls_button TO e_object->mt_toolbar.
        CLEAR : ls_button.

        ls_button-function = 'FC1'.
        ls_button-butn_type = 0.
        ls_button-icon = icon_detail.
        ls_button-text = '빠른 예약 고객'.
        APPEND ls_button TO e_object->mt_toolbar.
        CLEAR : ls_button.

      ENDMETHOD.
```

## CStom menu에 사용될 screen 생성
- 기본 STATUS, USER_COMMAND, CLEAR ok_Code 모듈 설치
- DAYS 상위 5명에 대한 표시 사항 STRUCTURE 생성

>테이블로 선언해서 인덱스로 루프돌리고 어펜드 하는 방식은 어떨까?

```abap
    DATA :
      data_id_1     LIKE gs_data-customid,
      data_name_1   LIKE gs_data-name,
      data_days_1   LIKE gs_data-days,

      data_id_2     LIKE gs_data-customid,
      data_name_2   LIKE gs_data-name,
      data_days_2   LIKE gs_data-days,

      data_id_3     LIKE gs_data-customid,
      data_name_3   LIKE gs_data-name,
      data_days_3   LIKE gs_data-days,

      data_id_4     LIKE gs_data-customid,
      data_name_4   LIKE gs_data-name,
      data_days_4   LIKE gs_data-days,

      data_id_5     LIKE gs_data-customid,
      data_name_5   LIKE gs_data-name,
      data_days_5   LIKE gs_data-days.
```
- 메쏘드 구현
```abap
      METHOD on_user_command.                          " user_command(커스텀 메뉴 활용) 메쏘드 내용 작성      
        CASE e_ucomm.

          WHEN 'FC1'.
            CALL SCREEN 110
              STARTING AT 10 5.

        ENDCASE.

      ENDMETHOD.
```

