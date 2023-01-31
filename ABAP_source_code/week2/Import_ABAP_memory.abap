*&---------------------------------------------------------------------*
*& Report ZABAP_E01_022
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_e01_022.

DATA: GS_SCARR TYPE SCARR,
      GT_DATA  TYPE TABLE OF SFLIGHT,
      GS_DATA  LIKE LINE OF GT_DATA.

IMPORT
  CARRIER = GS_SCARR
  FLIGHT = GT_DATA
  FROM MEMORY ID 'EXP'.

WRITE:/ GS_SCARR-CARRID,
        GS_SCARR-CARRNAME,
        GS_SCARR-CURRCODE.

ULINE.

LOOP AT GT_data INTO gs_data.
  WRITE:/ gs_data-connid,
          gs_data-FLDATE,
          GS_DATA-SEATSMAX,
          gs_data-SEATSOCC.
ENDLOOP.