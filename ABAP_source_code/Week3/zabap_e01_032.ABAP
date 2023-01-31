*&---------------------------------------------------------------------*
*& Report ZABAP_E01_032
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_e01_032.

CONSTANTS : gc_mark TYPE char1 VALUE 'X'.

* OBLIGATORY : 해당 필드 값은 필수값이 됨.
* LOWER CASE : 대소문자를 구분해서 입력할 수 있게됨.
* MEMORY ID <> : SAP Memory를 사용하여 입력 값 저장함.
* DEFAULT <> : 말그대로 기본값 생성 메모리보다 우선함.
PARAMETERS: pa_car TYPE scarr-carrid OBLIGATORY LOWER CASE
                                     MEMORY ID car ."DEFAULT 'DL'.

*CHECJ BOX 생성
* 체크 박스에 체크가 되면 해당 변수에 'X'값이 들어감.
PARAMETERS : pa_chk1 as CHECKBOX DEFAULT 'X',
             pa_chk2 as CHECKBOX ,
             pa_chk3 as CHECKBOX DEFAULT 'X'.

*RADIO BUTTON 생성
*무조건 한개만 선택 가능함.
PARAMETERS : pa_rb1 RADIOBUTTON GROUP rbg ,
             pa_rb2 RADIOBUTTON GROUP rbg DEFAULT 'X',
             pa_rb3 RADIOBUTTON GROUP rbg.

* pa_chk1이 설정됐을때 진행방법
IF pa_chk1 = gc_mark.

* pa_chk1이 체크 안됐을 을때 진행방법
 else.
ENDIF.


* pa_chk2가 설정됐을때 진행방법
IF pa_chk2 = gc_mark.
ENDIF.
* pa_chk3이 체크 안됐을때.
IF pa_chk3 = ''.
ENDIF.

* 체크 박스에 체크 안된경우
IF pa_chk3 is INITIAL.


ENDIF.

* 체크 박스에 체크가 돼어져있다는 것을 의미
IF pa_chk1 = gc_mark.
ENDIF.

* 라디오 버튼은 그룹에서 1개만 선택될 수 있다.
CASE gc_mark. " 상수대신에 'X'가 올 수도 있음.
* 1번 라디오 버튼 선택
  WHEN pa_rb1.

* 2번 라디오 버튼 선택
  WHEN pa_rb2.

* 3번 라디오 버튼 선택
  WHEN pa_rb3.

*아무것도 선택 안했을 때
  WHEN OTHERS.

ENDCASE.