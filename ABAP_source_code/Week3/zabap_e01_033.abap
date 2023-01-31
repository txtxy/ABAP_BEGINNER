*&---------------------------------------------------------------------*
*& Report ZABAP_E01_033
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_e01_033.

* elementry 변수로 생성가능
DATA : gv_carrid TYPE scarr-carrid.
* Structure 변수로 생성가능.
DATA : gs_flight TYPE sflight.

** S-O 입력 필드 생성.
*SELECT-OPTIONS: so_car FOR gv_carrid
**                        필수입력값으로 생성
*                          OBLIGATORY,
**                        다중 선택 칸이 디스플레이되지않음.
** 스트럭쳐 변수의 필드이름으로 오는 경우가 많음
*so_con FOR gs_flight-connid no-EXTENSION,
**                           두번때 입력칸을 생략함.
**                       파라미터 대신에 사용해서 값입력이 없어도,
**                       데이터 가져올 수 있도록 설정하기 위해 사용함
*so_fdt FOR gs_flight-fldate no INTERVALS no-EXTENSION.

SELECTION-SCREEN BEGIN OF BLOCK blk1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: so_car FOR gv_carrid OBLIGATORY,
                  so_con FOR gs_flight-connid NO-EXTENSION,
                  so_fdt FOR gs_flight-fldate NO INTERVALS NO-EXTENSION.

SELECTION-SCREEN END OF BLOCK blk1.

SELECTION-SCREEN BEGIN OF BLOCK blk2 WITH FRAME.

  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 1(20) TEXT-c01.

* pos_low는 그 다음으로 올 수 있는 값의 최소 거리를 만들어준다.
* POS_LOW와 POS_HIGH는 컬럼 상수값으로 변경할 수 있지만 값이 서로 겹치게 만들어서는 안된다.
* FOR Field는 코멘트와 체크 박스를 연결해주는 문법
    SELECTION-SCREEN COMMENT pos_low(14) TEXT-c02 FOR FIELD pa_eco.
    PARAMETERS: pa_eco AS CHECKBOX.

* FOR Field가 설정되지 않았기때문에 Display Sccreen에서 설명문과 체크박스는 별도요소로 인식됨.
    SELECTION-SCREEN COMMENT pos_high(14) TEXT-c03.
    PARAMETERS : pa_biz AS CHECKBOX.

  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK blk2.