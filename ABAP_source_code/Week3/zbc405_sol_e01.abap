*&---------------------------------------------------------------------*
*&  Include BC405_INTRO_S1_TOP                                         *
*&---------------------------------------------------------------------*

DATA: gs_flight TYPE dv_flights,
      gt_flight LIKE TABLE OF gs_flight.
* DV_ : DB View의 접두사

CONSTANTS : gv_mark TYPE char1 VALUE 'X'.


SELECTION-SCREEN BEGIN OF SCREEN 1100 AS SUBSCREEN.

  SELECT-OPTIONS: so_air FOR gs_flight-carrid MEMORY ID car,
                  so_con FOR gs_flight-connid.
SELECTION-SCREEN END OF SCREEN 1100.

SELECTION-SCREEN BEGIN OF SCREEN 1200 AS SUBSCREEN.
  SELECT-OPTIONS:  so_fld FOR gs_flight-fldate NO INTERVALS.

SELECTION-SCREEN END OF SCREEN 1200 .

SELECTION-SCREEN BEGIN OF SCREEN 1300 AS SUBSCREEN.
  PARAMETERS : pa_all RADIOBUTTON GROUP rdo ,
               pa_DOM RADIOBUTTON GROUP rdo,
               pa_INT RADIOBUTTON GROUP rdo DEFAULT 'X'.
SELECTION-SCREEN END OF SCREEN 1300.

SELECTION-SCREEN BEGIN OF TABBED BLOCK tab_sel FOR 10 LINES.
  SELECTION-SCREEN tab (10) tab1 USER-COMMAND com1 DEFAULT SCREEN 1100.
  SELECTION-SCREEN tab (10) tab2 USER-COMMAND com2 DEFAULT SCREEN 1200.
  SELECTION-SCREEN tab (10) tab3 USER-COMMAND com3 DEFAULT SCREEN 1300.
SELECTION-SCREEN END OF BLOCK tab_sel.


*&---------------------------------------------------------------------*
*&  Include BC405_INTRO_S_E01                                          *
*&---------------------------------------------------------------------*

INITIALIZATION.
TAB1 = TEXT-CON.
TAB2 = text-fld.
tab3 = 'Flight type'(ftp).


tab_sel-activetab = 'COM2'.
tab_sel-dynnr = 1200.


    so_air-sign = 'I'.
    so_air-option = 'BT'.
    so_air-low = 'AA'.
    so_air-high  = 'QF'.
  APPEND so_air.

  CLEAR so_air.

    so_air-sign = 'E'.
    so_air-option = 'EQ'.
    so_air-low = 'AZ'.
  APPEND so_air.

