*&---------------------------------------------------------------------*
*& Report ZQUIZ_E00_15_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZQUIZ_E01_15_02.

* ALV grid list data - internal table & work area.
DATA: GT_DATA TYPE TABLE OF ZSQUIZ15_E00,
      GS_DATA LIKE LINE OF GT_DATA.

* Screen function code variable.
DATA: OK_CODE TYPE SY-UCOMM.

* Container & ALV Grid 참조 변수.
DATA: GO_CONT TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
      GO_ALV  TYPE REF TO CL_GUI_ALV_GRID.

* ALV Grid layout.
DATA: GS_LAYOUT TYPE LVC_S_LAYO.

* Selection Screen - 입력 필드.

SELECTION-SCREEN BEGIN OF BLOCK BLK1 WITH FRAME TITLE TEXT-T01.

  SELECT-OPTIONS: SO_ID FOR GS_DATA-ID OBLIGATORY MEMORY ID CMS.

  PARAMETERS: pa_BP TYPE scustom-custtype.
  PARAMETERS: PA_NAME TYPE SCUSTOM-NAME.

SELECTION-SCREEN END OF BLOCK BLK1.

START-OF-SELECTION.
  PERFORM GET_DATA.

  CALL SCREEN 100.
*&---------------------------------------------------------------------*
*& Form GET_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM GET_DATA .

* Customer name like 검색에 필요한 변수.
  DATA: LV_NAME TYPE STRING.
*   RAnge를 활용한 parameter 조건 활용                         
  DATA : rt_custtype type RANGE OF scustom-custtype,
         wa_custtype LIKE LINE OF rt_custtype.

* Customer name like 검색 설정.
  LV_NAME = '%' && PA_NAME && '%'.
  
* b/p customer에 값을 입력하면 
IF pa_bp is not INITIAL.                         "PA를 ITAB으로 바꿔서 처리하는 것임,

  wa_custtype-sign = 'I'.
  wa_custtype-option = 'EQ'.
  wa_custtype-low = pa_bp.
  APPEND wa_custtype to rt_custtype.

ENDIF.

  SELECT *
    INTO CORRESPONDING FIELDS OF TABLE GT_DATA
    FROM SCUSTOM
    WHERE ID IN SO_ID
      AND CUSTTYPE in rt_custtype
      AND NAME LIKE LV_NAME.

  LOOP AT GT_DATA INTO GS_DATA.
    SELECT COUNT( * )
      INTO GS_DATA-BOOK_CNT
      FROM SBOOK
      WHERE CUSTOMID = GS_DATA-ID
        AND CANCELLED = SPACE.

    IF GS_DATA-BOOK_CNT < 10.
      GS_DATA-CUST_GRADE = 'Silver'.
      GS_DATA-EXCP_FLD = 1.
    ELSEIF GS_DATA-BOOK_CNT >= 10 AND GS_DATA-BOOK_CNT < 50.
      GS_DATA-CUST_GRADE = 'Gold'.
      GS_DATA-EXCP_FLD = 2.
    ELSE.
      GS_DATA-CUST_GRADE = 'Platinum'.
      GS_DATA-EXCP_FLD = 3.
    ENDIF.

    MODIFY GT_DATA FROM GS_DATA.
    CLEAR: GS_DATA.
  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE STATUS_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CLEAR_OKCODE OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE CLEAR_OKCODE OUTPUT.
  CLEAR: OK_CODE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_ALV OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE INIT_ALV OUTPUT.

* Container가 생성되어 있지 않으면 생성.
  IF GO_CONT IS INITIAL.

    CREATE OBJECT GO_CONT
      EXPORTING
        CONTAINER_NAME              = 'AREA'
      EXCEPTIONS
        CNTL_ERROR                  = 1
        CNTL_SYSTEM_ERROR           = 2
        CREATE_ERROR                = 3
        LIFETIME_ERROR              = 4
        LIFETIME_DYNPRO_DYNPRO_LINK = 5
        OTHERS                      = 6.
    IF SY-SUBRC <> 0.
*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

    CREATE OBJECT GO_ALV
      EXPORTING
        I_PARENT          = GO_CONT
      EXCEPTIONS
        ERROR_CNTL_CREATE = 1
        ERROR_CNTL_INIT   = 2
        ERROR_CNTL_LINK   = 3
        ERROR_DP_CREATE   = 4
        OTHERS            = 5.
    IF SY-SUBRC <> 0.
*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

    PERFORM SET_LAYOUT.

    CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY
      EXPORTING
*       I_BUFFER_ACTIVE               =
*       I_BYPASSING_BUFFER            =
*       I_CONSISTENCY_CHECK           =
        I_STRUCTURE_NAME              = 'ZSQUIZ15_E00'
*       IS_VARIANT                    =
*       I_SAVE                        =
*       I_DEFAULT                     = 'X'
        IS_LAYOUT                     = GS_LAYOUT
*       IS_PRINT                      =
*       IT_SPECIAL_GROUPS             =
*       IT_TOOLBAR_EXCLUDING          =
*       IT_HYPERLINK                  =
*       IT_ALV_GRAPHICS               =
*       IT_EXCEPT_QINFO               =
*       IR_SALV_ADAPTER               =
      CHANGING
        IT_OUTTAB                     = GT_DATA
*       IT_FIELDCATALOG               =
*       IT_SORT                       =
*       IT_FILTER                     =
      EXCEPTIONS
        INVALID_PARAMETER_COMBINATION = 1
        PROGRAM_ERROR                 = 2
        TOO_MANY_LINES                = 3
        OTHERS                        = 4.
    IF SY-SUBRC <> 0.
*     Implement suitable error handling here
    ENDIF.




  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Form SET_LAYOUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SET_LAYOUT .

  GS_LAYOUT-ZEBRA = 'X'.
  GS_LAYOUT-CWIDTH_OPT = 'X'.
  GS_LAYOUT-EXCP_FNAME = 'EXCP_FLD'.
  GS_LAYOUT-EXCP_LED   = 'X'.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.
  CASE OK_CODE.
    WHEN 'BACK' OR 'CANCEL'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.