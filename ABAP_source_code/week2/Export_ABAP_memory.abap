*&---------------------------------------------------------------------*
*& Report ZABAP_E01_021
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZABAP_E01_021.

DATA: GS_CARRIER TYPE SCARR,
      GT_FLIGHT  TYPE TABLE OF SFLIGHT.

PARAMETERS: PA_CAR TYPE SCARR-CARRID.

SELECT SINGLE *
  INTO GS_CARRIER
  FROM SCARR
  WHERE CARRID = PA_CAR.

SELECT *
  INTO TABLE GT_FLIGHT
  FROM SFLIGHT
  WHERE CARRID = PA_CAR.

EXPORT
  CARRIER = GS_CARRIER
  FLIGHT = GT_FLIGHT
  TO MEMORY ID 'EXP'.