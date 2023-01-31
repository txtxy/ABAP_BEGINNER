*&---------------------------------------------------------------------*
*& Report ZABAP_E01_024
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZABAP_E01_024.


DATA : gt_book TYPE TABLE OF sbook,
      gs_book LIKE LINE OF gt_book
      .

PARAMETERS : pa_carr TYPE sbook-carrid,
              pa_conn TYPE sbook-connid,
              pa_fdat TYPE sbook-fldate
              .
INITIALIZATION
.
*SAP Memory에서 ID가 CAR, CON에서
*데이터 읽어와서 pa_car, pa_conn에할당.
GET PARAMETER ID 'CAR' FIELD pa_Carr.
GET PARAMETER ID 'CON' FIELD pa_conn.

START-OF-SELECTION
.
SELECT *
  INTO TABLE gt_book
  FROM sbook
  WHERE carrid = pa_carr and
        connid = pa_conn and
        FLdate = pa_fdat
  .

 LOOP AT gt_book INTO gs_book
   .

   WRITE:/ gs_book-carrid,
           gs_book-connid,
           gs_book-fldate,
           gs_book-bookid,
           gs_book-customid
           .


 ENDLOOP.