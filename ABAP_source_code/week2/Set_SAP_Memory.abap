*&---------------------------------------------------------------------*
*& Report ZABAP_E01_023
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_e01_023.

DATA: gt_flight TYPE TABLE OF sflight,
      gs_flight LIKE LINE OF gt_flight
      .
PARAMETERS : pa_car TYPE sflight-carrid,
             pa_con TYPE sflight-connid
             .
*SAP Memory에서 CAR, CON ID로
*pa_car, pa_con에 할당된 데이터 저장.
SET PARAMETER ID 'CAR' FIELD pa_car.
SET PARAMETER ID 'CON' FIELD pa_con.

SELECT *
  INTO CORRESPONDING FIELDS OF TABLE gt_flight
  FROM sflight
  WHERE carrid = pa_car and
        connid = pa_con
  .

LOOP AT gt_flight INTO gs_flight.
  WRITE :/ gs_flight-carrid,
           gs_flight-connid,
           gs_flight-fldate,
           gs_flight-seatsmax,
           gs_flight-seatsocc
           .
ENDLOOP.