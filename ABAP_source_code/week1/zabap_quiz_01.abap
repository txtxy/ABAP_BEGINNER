*&---------------------------------------------------------------------*
*& Report ZQUIZ_E01_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zquiz_e01_01.

* 데이터 타입 선언을 먼저 한다.
TYPES: tv_type TYPE c LENGTH 1.

* 변수선언을 다음으로 하고
DATA: gv_result TYPE p LENGTH 8 DECIMALS 2. " 결과값 변수
CONSTANTS gc_pi TYPE f VALUE '3.14'. " 파이의 상수

* 스크린을 만들어서 입력값을 찾을 수 있도록함.
PARAMETERS: pa_radi TYPE I,
            pa_type TYPE tv_type.

CASE pa_type.

    WHEN 'S'.
        GV_result = ( pa_radi ** 2 ) * gc_PI.
        WRITE:/ '원의 넓이 : ', GV_result.

    WHEN 'L'.
        GV_result = ( pa_radi * 2 ) * gc_PI.
        WRITE:/ '원의 둘레 : ', GV_result .

    WHEN OTHERS.
        WRITE :/ 'S 또는 L을 입력하세요.'.

ENDCASE.

*IF pa_type = 'S'. " 조건문 시작
** pa_type이 'S'일 경우
*  gv_result = pa_radi ** 2 * gc_pi .
*  WRITE:/ '원의 넓이 : ', gv_result.
** 원의 넓이를 계산해서 출력
*ELSEIF pa_type = 'L'.
** pa_type이 'l'일 경우
*  gv_result = pa_radi * 2 * gc_pi. "원 둘레 공식
*  WRITE:/ '원의 둘레 : ', gv_result.
** 원의 둘레를 계산하여 출력
*ELSE.
** pa_type이 'L' OR 'S'가 아닌 다른 경우.
*  WRITE :/ 'S 또는 L을 입력하세요.'.
** 입력 오류 안내.
*ENDIF. " 조건문 종료