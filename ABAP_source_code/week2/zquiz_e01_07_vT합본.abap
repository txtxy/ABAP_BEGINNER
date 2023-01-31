*&---------------------------------------------------------------------*
*& Report ZQUIZ_E01_07
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zquiz_e01_07.

* 가능하면 DB접근을 최소화 하기 위해서 중요정보를 모두 인터널 테이블로 옮기는 작업을 1회 실행하는 것이 좋을 듯.
* REad internal table 구문을 사용해보자
* Modify internal table 구문을 이용하요 계산값을 적용하자
* 인터널 테이블 루프를 여러번 돌리는것이 빠른지
* DB접근을 여러번하는게 빠른지 확인이 필요하다.


*--------------------------------------------------------------------------------

* 출력을 위한 인터널 테이블 타입 선언
TYPES: BEGIN OF ts_answer,
         carrid     TYPE sflight-carrid,
         carrname   TYPE scarr-carrname,
         connid     TYPE sflight-connid,
         fldate     TYPE sflight-fldate,
         seatsmax   TYPE sflight-seatsmax,
         seatsmax_b TYPE sflight-seatsmax_b,
         seatsmax_f TYPE sflight-seatsmax_f,
         seatsocc   TYPE sflight-seatsocc,
         seatsocc_b TYPE sflight-seatsocc_b,
         seatsocc_f TYPE sflight-seatsocc_f,
         seatsdif   TYPE sflight-seatsmax,
         private    TYPE i,
         business   TYPE i,
       END OF ts_answer.

* 인터널 테이블 선언
DATA :
*  gt_sflight TYPE TABLE OF sflight,
*  gt_scarr   TYPE TABLE OF scarr,
  lt_answer  TYPE STANDARD TABLE OF ts_answer
                  WITH NON-UNIQUE KEY carrid connid.

**로컬 value 선언
*DATA :
*  lv_private  TYPE i,   " 개인고객 카운트 값을 변수가 아니라 답안 테이블에 입력
*  lv_business TYPE i.   " 기업고객 카운트 값을 변수가 아니라 답안 테이블에 입력

* Structure value 선언 .
DATA :
*  gs_sflights LIKE LINE OF gt_sflight, " 전역변수를 사용하지 않았어서 선언이 불필요했음
*  gs_scarr    LIKE LINE OF gt_scarr,   " 전역변수를 사용하지 않았어서 선언이 불필요했음
  ls_answer   TYPE ts_answer.


* 파라미터 입력 속성 부여.
PARAMETERS: pa_carid LIKE scarr-carrid,
            pa_conid LIKE sflight-connid.

* 초기화
INITIALIZATION.

* Main code 실행
START-OF-SELECTION.

* 기본 사용 데이터 JOIN 및 Parameter 입력값 적용
  SELECT f~carrid c~carrname f~connid f~fldate
         f~seatsmax f~seatsmax_b f~seatsmax_f
         f~seatsocc f~seatsocc_b f~seatsocc_f
    INTO CORRESPONDING FIELDS OF TABLE lt_answer
    FROM sflight AS f JOIN scarr AS c ON f~carrid = c~carrid
    WHERE f~carrid = pa_carid AND
          f~connid = pa_conid.

*--------------------------------------------------------------------------------
** 기본 사용 데이터 JOIN 및 전체 데이터 조회
** 파라미터 입력이 부족하면 그값 전체 조회할 수 있음
*  SELECT f~carrid c~carrname f~connid f~fldate
*         f~seatsmax f~seatsmax_b f~seatsmax_f
*         f~seatsocc f~seatsocc_b f~seatsocc_f
*    INTO CORRESPONDING FIELDS OF TABLE lt_answer
*    FROM sflight AS f JOIN scarr AS c ON f~carrid = c~carrid.

*--------------------------------------------------------------------------------
*                         루프외부로 값 옮기는 방법 도전중
** 개인 고객 COUNT값 부여
*      SELECT COUNT( custtype ) as private    " private 합계
*            APPENDING CORRESPONDING FIELDS OF TABLE @lt_answer
*            FROM sbook
*            WHERE carrid = @ls_answer-carrid AND
*                  connid = @ls_answer-connid AND
*                  fldate = @ls_answer-fldate AND
*                  custtype = 'P'.
** 기업 고객 COUNT값 부여
*      SELECT COUNT( custtype ) as business    " Business 합계
*            APPENDING CORRESPONDING FIELDS OF TABLE @lt_answer
*            FROM sbook
*            WHERE carrid = @ls_answer-carrid AND
*                  connid = @ls_answer-connid AND
*                  fldate = @ls_answer-fldate AND
*                  custtype = 'B'.
*--------------------------------------------------------------------------------

* 비행 일정에 따른 ORDERing
* SORT lt_answer by fldate ASCENDING .

* 후방에서 입력 조건 부여
*    IF ls_answer-carrid <> pa_carid AND ls_answer-connid <> pa_conid.
*      CONTINUE.
*    ELSE.

*출력 LOOP 실행
  LOOP AT lt_answer INTO ls_answer .


* 좌석수 옵션 계산
    ls_answer-seatsmax = ls_answer-seatsmax + ls_answer-seatsmax_b + ls_answer-seatsmax_f.
    ls_answer-seatsocc = ls_answer-seatsocc + ls_answer-seatsocc_b + ls_answer-seatsocc_f.
    ls_answer-seatsdif =  ls_answer-seatsmax  - ( ls_answer-seatsocc ).

*--------------------------------------------------------------------------------
* 내가 짠 비효율적인 코드
*    SELECT COUNT(*) b~connid b~fldate    " private 합계
*      INTO ls_cal
*      FROM sbook AS a
*      JOIN sflight AS b
*      ON a~connid = b~connid
*      WHERE a~carrid = ls_answer-carrid AND
*            a~connid = ls_answer-connid AND
*            a~fldate = ls_answer-fldate AND
*            a~custtype = 'P'
*       GROUP BY b~connid b~fldate
*     .
*    ENDSELECT.
*--------------------------------------------------------------------------------
* 개인 고객 COUNT값 부여
    SELECT COUNT(*)     " private 합계
          INTO ls_answer-private
          FROM sbook
          WHERE carrid = ls_answer-carrid AND
                connid = ls_answer-connid AND
                fldate = ls_answer-fldate AND
                custtype = 'P'.
* 기업 고객 COUNT값 부여
    SELECT COUNT(*)     " business 합계
     INTO ls_answer-business
     FROM sbook
     WHERE carrid = ls_answer-carrid AND
           connid = ls_answer-connid AND
           fldate = ls_answer-fldate AND
           custtype = 'B'.
*--------------------------------------------------------------------------------
* 답안 출력
    WRITE:/ ls_answer-carrid,
            ls_answer-carrname,
            ls_answer-connid,
            ls_answer-fldate,
            ls_answer-seatsmax ,
            ls_answer-seatsocc,
            ls_answer-seatsdif,
            ls_answer-private,
            ls_answer-business.


  ENDLOOP.

*ENDIF.


*&---------------------------------------------------------------------*
*& Report ZQUIZ_E00_07_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZQUIZ_E01_07_01_TVERSION.

* Output에 대한 필드 Structure 선언.
DATA: BEGIN OF GS_OUTPUT,
        CARRID   TYPE SFLIGHT-CARRID,
        CARRNAME TYPE SCARR-CARRNAME,
        CONNID   TYPE SFLIGHT-CONNID,
        FLDATE   TYPE SFLIGHT-FLDATE,
        SEATSMAX TYPE SFLIGHT-SEATSMAX,
        SEATSOCC TYPE SFLIGHT-SEATSOCC,
        SEATSDIF TYPE SFLIGHT-SEATSMAX,
        PRIVATE  TYPE I,
        BUSINESS TYPE I,
      END OF GS_OUTPUT.

* Output에 대한 필드 Internal Table 선언.
DATA: GT_OUTPUT LIKE TABLE OF GS_OUTPUT.

* 테이블에서 데이터 읽어서 할당할 Internal Table 선언.
* Structure 선언.
DATA: GT_FLIGHT TYPE TABLE OF SFLIGHT,
      GS_FLIGHT LIKE LINE OF GT_FLIGHT.

* Selection Screen.
PARAMETERS: PA_CAR TYPE SFLIGHT-CARRID,
            PA_CON TYPE SFLIGHT-CONNID.

* SBOOK 테이블에서 데이터 읽어옴.
SELECT * INTO TABLE GT_FLIGHT
  FROM SFLIGHT
  WHERE CARRID = PA_CAR
    AND CONNID = PA_CON.

LOOP AT GT_FLIGHT INTO GS_FLIGHT.
  MOVE-CORRESPONDING GS_FLIGHT TO GS_OUTPUT.

  GS_OUTPUT-SEATSMAX = GS_FLIGHT-SEATSMAX +
                       GS_FLIGHT-SEATSMAX_B +
                       GS_FLIGHT-SEATSMAX_F.

  GS_OUTPUT-SEATSOCC = GS_FLIGHT-SEATSOCC +
                       GS_FLIGHT-SEATSOCC_B +
                       GS_FLIGHT-SEATSOCC_F.

  GS_OUTPUT-SEATSDIF = GS_OUTPUT-SEATSMAX -
                       GS_OUTPUT-SEATSOCC.

  SELECT COUNT( * )
    FROM SBOOK
    INTO GS_OUTPUT-PRIVATE
    WHERE CARRID = GS_FLIGHT-CARRID
      AND CONNID = GS_FLIGHT-CONNID
      AND FLDATE = GS_FLIGHT-FLDATE
      AND CUSTTYPE = 'P'.

  SELECT COUNT( * )
    FROM SBOOK
    INTO GS_OUTPUT-BUSINESS
    WHERE CARRID = GS_FLIGHT-CARRID
      AND CONNID = GS_FLIGHT-CONNID
      AND FLDATE = GS_FLIGHT-FLDATE
      AND CUSTTYPE = 'B'.

  SELECT SINGLE CARRNAME INTO GS_OUTPUT-CARRNAME
    FROM SCARR
    WHERE CARRID = GS_FLIGHT-CARRID.

  APPEND GS_OUTPUT TO GT_OUTPUT.

ENDLOOP.

LOOP AT GT_OUTPUT INTO GS_OUTPUT.
  WRITE:/ GS_OUTPUT-CARRID,
          GS_OUTPUT-CARRNAME,
          GS_OUTPUT-CONNID,
          GS_OUTPUT-FLDATE,
          GS_OUTPUT-SEATSMAX,
          GS_OUTPUT-SEATSOCC,
          GS_OUTPUT-SEATSDIF,
          GS_OUTPUT-PRIVATE,
          GS_OUTPUT-BUSINESS.
ENDLOOP.

*&---------------------------------------------------------------------*
*& Report ZQUIZ_E00_07_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zquiz_e01_07_02_tversion.

* 인투 절이오면 조회 순서와 타겟 순서가 동일하게 맞춰짐.
* 즉 이름으로 구분하지 않고 조회순서에 따라 입력됨.
* 만약 into corresponding fields of를 사용했다면 입력되지 않는다.


* Output에 대한 필드 Structure 선언.
DATA: BEGIN OF GS_OUTPUT,
        CARRID   TYPE SFLIGHT-CARRID,
        CARRNAME TYPE SCARR-CARRNAME,
        CONNID   TYPE SFLIGHT-CONNID,
        FLDATE   TYPE SFLIGHT-FLDATE,
        SEATSMAX TYPE SFLIGHT-SEATSMAX,
        SEATSOCC TYPE SFLIGHT-SEATSOCC,
        SEATSDIF TYPE SFLIGHT-SEATSMAX,
        PRIVATE  TYPE I,
        BUSINESS TYPE I,
      END OF GS_OUTPUT.

* Output에 대한 필드 Internal Table 선언.
DATA: GT_OUTPUT LIKE TABLE OF GS_OUTPUT.

* 테이블에서 데이터 읽어서 할당할 Internal Table 선언.
* Structure 선언.
DATA: GT_FLIGHT TYPE TABLE OF SFLIGHT,
      GS_FLIGHT LIKE LINE OF GT_FLIGHT.

* 항공사 코드, 이름에 대한 Internal table &
* Structure 선언.
DATA: GT_CARRIER TYPE TABLE OF SCARR,
      GS_CARRIER LIKE LINE OF GT_CARRIER.

* Private, Business 고객 수에 대한
* Internal Table & Structure.
DATA: BEGIN OF GS_CUST,
        CARRID   TYPE SBOOK-CARRID,
        CONNID   TYPE SBOOK-CONNID,
        FLDATE   TYPE SBOOK-FLDATE,
        CUSTTYPE TYPE SBOOK-CUSTTYPE,
        CNT      TYPE I,
      END OF GS_CUST.

DATA: GT_CUST LIKE TABLE OF GS_CUST.

* Selection Screen.
PARAMETERS: PA_CAR TYPE SFLIGHT-CARRID,
            PA_CON TYPE SFLIGHT-CONNID.

INITIALIZATION.
* 항공사 코드 & 이름 읽어옴.
  SELECT * INTO TABLE GT_CARRIER
    FROM SCARR.

START-OF-SELECTION.
* Private, Business 고객에 대한 수 읽어옴.
  SELECT CARRID CONNID FLDATE CUSTTYPE
         COUNT( * )
    INTO TABLE GT_CUST
    FROM SBOOK
    WHERE CARRID = PA_CAR
      AND CONNID = PA_CON
    GROUP BY CARRID CONNID FLDATE CUSTTYPE.


* SBOOK 테이블에서 데이터 읽어옴.
  SELECT * INTO TABLE GT_FLIGHT
    FROM SFLIGHT
    WHERE CARRID = PA_CAR
      AND CONNID = PA_CON.

  LOOP AT GT_FLIGHT INTO GS_FLIGHT.
    MOVE-CORRESPONDING GS_FLIGHT TO GS_OUTPUT.

    GS_OUTPUT-SEATSMAX = GS_FLIGHT-SEATSMAX +
                         GS_FLIGHT-SEATSMAX_B +
                         GS_FLIGHT-SEATSMAX_F.

    GS_OUTPUT-SEATSOCC = GS_FLIGHT-SEATSOCC +
                         GS_FLIGHT-SEATSOCC_B +
                         GS_FLIGHT-SEATSOCC_F.

    GS_OUTPUT-SEATSDIF = GS_OUTPUT-SEATSMAX -
                         GS_OUTPUT-SEATSOCC.

*    SELECT COUNT( * )
*      FROM SBOOK
*      INTO GS_OUTPUT-PRIVATE
*      WHERE CARRID = GS_FLIGHT-CARRID
*        AND CONNID = GS_FLIGHT-CONNID
*        AND FLDATE = GS_FLIGHT-FLDATE
*        AND CUSTTYPE = 'P'.
*
*    SELECT COUNT( * )
*      FROM SBOOK
*      INTO GS_OUTPUT-BUSINESS
*      WHERE CARRID = GS_FLIGHT-CARRID
*        AND CONNID = GS_FLIGHT-CONNID
*        AND FLDATE = GS_FLIGHT-FLDATE
*        AND CUSTTYPE = 'B'.

* Private 고객 수 읽어옴.
    READ TABLE GT_CUST INTO GS_CUST
      WITH KEY CARRID = GS_FLIGHT-CARRID
               CONNID = GS_FLIGHT-CONNID
               FLDATE = GS_FLIGHT-FLDATE
               CUSTTYPE = 'P'.
    IF SY-SUBRC = 0.
      GS_OUTPUT-PRIVATE = GS_CUST-CNT.
    ENDIF.

* Business 고객 수 읽어옴.
    READ TABLE GT_CUST INTO GS_CUST
      WITH KEY CARRID = GS_FLIGHT-CARRID
               CONNID = GS_FLIGHT-CONNID
               FLDATE = GS_FLIGHT-FLDATE
               CUSTTYPE = 'B'.
    IF SY-SUBRC = 0.
      GS_OUTPUT-BUSINESS = GS_CUST-CNT.
    ENDIF.

* GT_CARRIER Internal Table에서 항공사 이름 읽어옴.
    READ TABLE GT_CARRIER INTO GS_CARRIER
      WITH KEY CARRID = GS_FLIGHT-CARRID.
    IF SY-SUBRC = 0.
      GS_OUTPUT-CARRNAME = GS_CARRIER-CARRNAME.
    ENDIF.

    APPEND GS_OUTPUT TO GT_OUTPUT.

    CLEAR: GS_OUTPUT, GS_FLIGHT, GS_CARRIER, GS_CUST.
  ENDLOOP.

  LOOP AT GT_OUTPUT INTO GS_OUTPUT.
    WRITE:/ GS_OUTPUT-CARRID,
            GS_OUTPUT-CARRNAME,
            GS_OUTPUT-CONNID,
            GS_OUTPUT-FLDATE,
            GS_OUTPUT-SEATSMAX,
            GS_OUTPUT-SEATSOCC,
            GS_OUTPUT-SEATSDIF,
            GS_OUTPUT-PRIVATE,
            GS_OUTPUT-BUSINESS.
  ENDLOOP.

  *&---------------------------------------------------------------------*
*& Report ZQUIZ_E00_07_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZQUIZ_E01_07_03.
*조인을 이용한 방법 예시
* Output에 대한 필드 Structure 선언.
DATA: BEGIN OF GS_OUTPUT,
        CARRID     TYPE SFLIGHT-CARRID,
        CARRNAME   TYPE SCARR-CARRNAME,
        CONNID     TYPE SFLIGHT-CONNID,
        FLDATE     TYPE SFLIGHT-FLDATE,
        SEATSMAX   TYPE SFLIGHT-SEATSMAX,
        SEATSOCC   TYPE SFLIGHT-SEATSOCC,
        SEATSMAX_B TYPE SFLIGHT-SEATSMAX_B,
        SEATSOCC_B TYPE SFLIGHT-SEATSOCC_B,
        SEATSMAX_F TYPE SFLIGHT-SEATSMAX_F,
        SEATSOCC_F TYPE SFLIGHT-SEATSOCC_F,
        SEATSDIF   TYPE SFLIGHT-SEATSMAX,
        PRIVATE    TYPE I,
        BUSINESS   TYPE I,
      END OF GS_OUTPUT.

* Output에 대한 필드 Internal Table 선언.
DATA: GT_OUTPUT LIKE TABLE OF GS_OUTPUT.

* 테이블에서 데이터 읽어서 할당할 Internal Table 선언.
* Structure 선언.
DATA: GT_FLIGHT TYPE TABLE OF SFLIGHT,
      GS_FLIGHT LIKE LINE OF GT_FLIGHT.

* 항공사 코드, 이름에 대한 Internal table &
* Structure 선언.
DATA: GT_CARRIER TYPE TABLE OF SCARR,
      GS_CARRIER LIKE LINE OF GT_CARRIER.

* Private, Business 고객 수에 대한
* Internal Table & Structure.
DATA: BEGIN OF GS_CUST,
        CARRID   TYPE SBOOK-CARRID,
        CONNID   TYPE SBOOK-CONNID,
        FLDATE   TYPE SBOOK-FLDATE,
        CUSTTYPE TYPE SBOOK-CUSTTYPE,
        CNT      TYPE I,
      END OF GS_CUST.

DATA: GT_CUST LIKE TABLE OF GS_CUST.

* Selection Screen.
PARAMETERS: PA_CAR TYPE SFLIGHT-CARRID,
            PA_CON TYPE SFLIGHT-CONNID.

INITIALIZATION.
* 항공사 코드 & 이름 읽어옴.
  SELECT * INTO TABLE GT_CARRIER
    FROM SCARR.

START-OF-SELECTION.
* Private, Business 고객에 대한 수 읽어옴.
  SELECT CARRID CONNID FLDATE CUSTTYPE
         COUNT( * ) AS CNT
    INTO CORRESPONDING FIELDS OF TABLE GT_CUST
    FROM SBOOK
    WHERE CARRID = PA_CAR
      AND CONNID = PA_CON
    GROUP BY CARRID CONNID FLDATE CUSTTYPE.

* SBOOK, SCARR 테이블에서 데이터 읽어옴.
  SELECT A~CARRID A~CONNID A~FLDATE
         A~SEATSMAX A~SEATSOCC
         A~SEATSMAX_B A~SEATSOCC_B
         A~SEATSMAX_F A~SEATSOCC_F
         B~CARRNAME
    INTO CORRESPONDING FIELDS OF TABLE GT_OUTPUT
    FROM SFLIGHT AS A INNER JOIN SCARR AS B
                      ON A~CARRID = B~CARRID
    WHERE A~CARRID = PA_CAR
      AND A~CONNID = PA_CON.

  LOOP AT GT_OUTPUT INTO GS_OUTPUT.

    GS_OUTPUT-SEATSMAX = GS_OUTPUT-SEATSMAX +
                         GS_OUTPUT-SEATSMAX_B +
                         GS_OUTPUT-SEATSMAX_F.

    GS_OUTPUT-SEATSOCC = GS_OUTPUT-SEATSOCC +
                         GS_OUTPUT-SEATSOCC_B +
                         GS_OUTPUT-SEATSOCC_F.

    GS_OUTPUT-SEATSDIF = GS_OUTPUT-SEATSMAX -
                         GS_OUTPUT-SEATSOCC.

*    SELECT COUNT( * )
*      FROM SBOOK
*      INTO GS_OUTPUT-PRIVATE
*      WHERE CARRID = GS_FLIGHT-CARRID
*        AND CONNID = GS_FLIGHT-CONNID
*        AND FLDATE = GS_FLIGHT-FLDATE
*        AND CUSTTYPE = 'P'.
*
*    SELECT COUNT( * )
*      FROM SBOOK
*      INTO GS_OUTPUT-BUSINESS
*      WHERE CARRID = GS_FLIGHT-CARRID
*        AND CONNID = GS_FLIGHT-CONNID
*        AND FLDATE = GS_FLIGHT-FLDATE
*        AND CUSTTYPE = 'B'.

* Private 고객 수 읽어옴.
    READ TABLE GT_CUST INTO GS_CUST
      WITH KEY CARRID = GS_OUTPUT-CARRID
               CONNID = GS_OUTPUT-CONNID
               FLDATE = GS_OUTPUT-FLDATE
               CUSTTYPE = 'P'.
    IF SY-SUBRC = 0.
      GS_OUTPUT-PRIVATE = GS_CUST-CNT.
    ENDIF.

* Business 고객 수 읽어옴.
    READ TABLE GT_CUST INTO GS_CUST
      WITH KEY CARRID = GS_OUTPUT-CARRID
               CONNID = GS_OUTPUT-CONNID
               FLDATE = GS_OUTPUT-FLDATE
               CUSTTYPE = 'B'.
    IF SY-SUBRC = 0.
      GS_OUTPUT-BUSINESS = GS_CUST-CNT.
    ENDIF.

* GT_CARRIER Internal Table에서 항공사 이름 읽어옴.
    READ TABLE GT_CARRIER INTO GS_CARRIER
      WITH KEY CARRID = GS_OUTPUT-CARRID.
    IF SY-SUBRC = 0.
      GS_OUTPUT-CARRNAME = GS_CARRIER-CARRNAME.
    ENDIF.

    MODIFY GT_OUTPUT FROM GS_OUTPUT.

    CLEAR: GS_OUTPUT, GS_FLIGHT, GS_CARRIER, GS_CUST.
  ENDLOOP.

  LOOP AT GT_OUTPUT INTO GS_OUTPUT.
    WRITE:/ GS_OUTPUT-CARRID,
            GS_OUTPUT-CARRNAME,
            GS_OUTPUT-CONNID,
            GS_OUTPUT-FLDATE,
            GS_OUTPUT-SEATSMAX,
            GS_OUTPUT-SEATSOCC,
            GS_OUTPUT-SEATSDIF,
            GS_OUTPUT-PRIVATE,
            GS_OUTPUT-BUSINESS.
  ENDLOOP.