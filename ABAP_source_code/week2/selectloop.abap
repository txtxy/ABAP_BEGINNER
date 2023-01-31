FUNCTION ZGET_E01_BOOKING.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CARRID) TYPE  SBOOK-CARRID
*"     REFERENCE(IV_CONNID) TYPE  SBOOK-CONNID
*"     REFERENCE(IV_FLDATE) TYPE  SBOOK-FLDATE
*"  EXPORTING
*"     REFERENCE(ET_BOOKINGS) TYPE  TY_BOOKINGS
*"  EXCEPTIONS
*"      NO_DATA
*"----------------------------------------------------------------------

DATA: ls_bookings TYPE sbook.

SELECT *
  INTO CORRESPONDING FIELDS OF ls_bookings
  from sbook
  where carrid = iv_carrid and
        connid = iv_connid and
        fldate = iv_fldate.

  APPEND ls_bookings to et_bookings.

endselect.




ENDFUNCTION.