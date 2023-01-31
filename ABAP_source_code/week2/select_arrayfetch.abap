FUNCTION ZBC400_E01_FLIGHTLIST_GE_OPT.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CARRID) TYPE  S_CARR_ID
*"     REFERENCE(IV_CONNID) TYPE  S_CONN_ID
*"  EXPORTING
*"     REFERENCE(ET_FLIGHTS) TYPE  BC400_T_FLIGHTS
*"  EXCEPTIONS
*"      NO_DATA
*"----------------------------------------------------------------------
  DATA: ls_flights TYPE LINE OF bc400_t_flights.

IF sy-subrc <> 0.
  RAISE no_data.
else.

select *
  from sflight
  into CORRESPONDING FIELDS OF TABLE et_flights
  where carrid = iv_carrid and
        connid = iv_connid.

LOOP AT et_flights into ls_flights.
    ls_flights-percentage = ls_flights-seatsocc / ls_flights-seatsmax * 100.

MODIFY TABLE et_flights FROM ls_flights TRANSPORTING percentage.
ENDLOOP.

ENDIF.

SORT et_flights by percentage DESCENDING .



ENDFUNCTION.