*&---------------------------------------------------------------------*
*& Report ZQUIZ_E01_09
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zquiz_e01_09.

DATA :
       gt_airline TYPE ztairline_e01,
       gt_schedule TYPE ztschedule_e01.

DATA : gs_airline like LINE OF gt_airline,
       gs_schdule LIKE LINE OF gt_schedule.


SELECT-OPTIONS : so_al FOR gs_airline-carrid.

INITIALIZATION.
  so_al-sign = 'I'.
  so_al-option = 'BT'.
  so_al-low = 'AA'.
  so_al-high = 'UA'.
  APPEND so_al.

START-OF-SELECTION.


 SELECT * INTO CORRESPONDING FIELDS OF TABLE gt_airline
   FROM scarr
   where carrid in so_al.

sort gt_airline by carrid ascending.


 LOOP AT gt_airline into gs_airline.

  WRITE:/ ICON_WS_PLANE as icon, gs_airline-carrid,gs_airline-CARRNAME.


  SELECT *
  INTO CORRESPONDING FIELDS OF gs_schdule
  FROM spfli
  where carrid = gs_airline-carrid.
           WRITE:/ gs_schdule-connid,
               gs_schdule-countryfr,
               gs_schdule-cityfrom,
               gs_schdule-airpfrom,
               gs_schdule-countryto,
               gs_schdule-cityto,
               gs_schdule-airpto.
  endselect.
ULINE.
 ENDLOOP.