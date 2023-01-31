*&---------------------------------------------------------------------*
*& Report ZABAP_E01_017
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_e01_017.

** Elementary variable
**DATA: gv_carrid TYPE s_carr_id.
**
**SELECT-OPTIONS : so_carr for gv_carrid.

* Structure vvariable
DATA : gs_spfil TYPE spfli,
       gt_spfli LIKE TABLE OF gs_spfil.

SELECT-OPTIONS: so_car FOR gs_spfil-carrid DEFAULT 'AA' to 'LH'. 

SELECT *
  FROM spfli
  INTO CORRESPONDING FIELDS OF TABLE gt_spfli
  WHERE carrid IN so_car.

LOOP AT gt_spfli INTO gs_spfil.
  WRITE:/ gs_spfil-mandt,
          gs_spfil-carrid,
          gs_spfil-connid,
          gs_spfil-countryfr,
          gs_spfil-cityfrom,
          gs_spfil-airpfrom,
          gs_spfil-countryto,
          gs_spfil-cityto,
          gs_spfil-airpto,
          gs_spfil-fltime.

ENDLOOP.