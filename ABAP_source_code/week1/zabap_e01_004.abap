*&---------------------------------------------------------------------*
*& Report ZABAP_E01_004
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_e01_004.

* Local data type
* 해당 프로그램에서만 사용 가능함.
TYPES : tv_perc TYPE p LENGTH 3 DECIMALS 2,
        tv_city TYPE c LENGTH 15.

* 변수선언
* VAlue를 추가하여 Default 값을 설정할 수 있음.
DATA : gv_perc   TYPE tv_perc,
       gv_num1   TYPE i value 20,
       gv_num2   LIKE gv_num1,
       gv_city   TYPE tv_city,
       gv_ciry1  TYPE c LENGTH 15 VALUE 'Seiul',
       gv_carrid TYPE s_carr_id.