*&---------------------------------------------------------------------*
*& Report ZABAP_E01_034
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_e01_034.

DATA: gs_data TYPE sbook.

SELECTION-SCREEN BEGIN OF SCREEN 1100 AS SUBSCREEN.
  SELECT-OPTIONS : so_car FOR gs_data-carrid,
                   so_con FOR  gs_data-connid.
SELECTION-SCREEN END OF SCREEN 1100.

SELECTION-SCREEN BEGIN OF SCREEN 1200 AS SUBSCREEN.
  PARAMETERS : pa_id TYPE sbook-customid,
               pa_nm TYPE scustom-name.
SELECTION-SCREEN END OF SCREEN 1200.


SELECTION-SCREEN BEGIN OF SCREEN 1300 AS SUBSCREEN.
  PARAMETERS : pa_all RADIOBUTTON GROUP rb1,
               pa_can RADIOBUTTON GROUP rb1,
               pa_val RADIOBUTTON GROUP rb1 DEFAULT 'X'.
SELECTION-SCREEN END OF SCREEN 1300.


SELECTION-SCREEN BEGIN OF TABBED BLOCK tab_str FOR 5 LINES.

  SELECTION-SCREEN  TAB (20) tab1 USER-COMMAND comm1 DEFAULT SCREEN 1100.
  " TAB (20) 탭페이지 타이틀의 길이
  SELECTION-SCREEN  TAB (20) tab2 USER-COMMAND comm2 DEFAULT SCREEN 1200.
  SELECTION-SCREEN  TAB (20) tab3 USER-COMMAND comm3 DEFAULT SCREEN 1300.

SELECTION-SCREEN END OF BLOCK tab_str.


INITIALIZATION.
  tab1 ='Connection'(001).
  tab2 ='Flight'(002).
  tab3 ='Booking'(003).
* 기본 적으로는 첫번째 탭이 Display됨.
  tab_str-activetab = 'COMM3'.
  tab_str-dynnr = 1200.
  