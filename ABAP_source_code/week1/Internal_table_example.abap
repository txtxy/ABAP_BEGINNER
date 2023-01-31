REPORT ZABAP_INTERNAL_TABLE_EXAMPLE.

DATA: gt_flight TYPE bc400_t_flights,
* Structure Baiable (work Area)
      gs_flight LIKE LINE OF gt_flight.

gs_flight-carrid = 'AA'.
gs_flight-connid = '00117'.
gs_flight-fldate = '20221220'.
gs_flight-seatsmax = 350.
gs_flight-seatsocc = 120.


* 마지막 ROW 뒤에 레코드 입력
APPEND gs_flight TO gt_flight.

gs_flight-carrid = 'AA'.
gs_flight-connid = '0064'.
gs_flight-fldate = '20221221'.
gs_flight-seatsmax = 350.
gs_flight-seatsocc = 110.

* 레코드 입력 Default 마지막
INSERT gs_flight INTO TABLE gt_flight.

gs_flight-carrid = 'LH'.
gs_flight-connid = '0400'.
gs_flight-fldate = '20221225'.
gs_flight-seatsmax = 350.
gs_flight-seatsocc = 220.

* rownum 2번에 레코드 입력
INSERT gs_flight INTO gt_flight INDEX 2.

* Internal table 특정 조건의 row 조회.
READ TABLE gt_flight INTO gs_flight INDEX 3.
*
*gs_flight-percentage = gs_flight-seatsocc / gs_flight-seatsmax * 100.
*
*MODIFY TABLE gt_flight FROM gs_flight.


gs_flight-fldate = sy-datum.
MODIFY gt_flight FROM gs_flight INDEX 2
    TRANSPORTING fldate.


* percentage 컬럼 값만 변경한다.
MODIFY gt_flight FROM gs_flight INDEX 3
TRANSPORTING percentage.
*
** internal table 데이터 삭제.
*DELETE gt_flight index 1.
* 처음서부터 2번째까지 삭제
DELETE gt_flight TO 3.

* 1번서부터 3번째까지 삭제
DELETE gt_flight FROM 1 TO 3.

*반복문 이용 전체 로우에 레코드 변경
LOOP AT gt_flight INTO gs_flight.

gs_flight-percentage = gs_flight-seatsocc / gs_flight-seatsmax * 100.

MODIFY TABLE gt_flight FROM gs_flight
  TRANSPORTING PERCENTAGE .

ENDLOOP.
