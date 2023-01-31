*&---------------------------------------------------------------------*
*& Report ZABAP_E01_009
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_e01_009.

* 결과값 변수 선언
DATA : gv_result  TYPE i.

* Selection Screen - 정수 입력필드 2개
PARAMETERS: pa_a TYPE i,
            pa_b TYPE i.

PERFORM xyz USING pa_a    " 액츄얼 파라미터
                  pa_b
            CHANGING gv_result.
                                    "여기까지 적고 subroutine 이름을 더블 클릭!하면 밑에 생긴다!
                        
PERFORM abc.


WRITE:/ 'Result : ', gv_result,
      / 'pa_a : ', pa_a,
      / 'pa_b : ', pa_b.

*&---------------------------------------------------------------------*
*& Form xyz
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> PA_A
*&      --> PA_B
*&      <-- GV_RESULT
*&---------------------------------------------------------------------*
" 이하 포멀 파라미터
FORM xyz  USING VALUE(pv_a) TYPE i " Call by value
                VALUE(pv_b) TYPE i " Call by value and Result
*       CHANGING VALUE(pv_result) TYPE i. " Call by value and Result
        CHANGING pv_result TYPE i. " Call by Reference.
*        pv_result = pa_a * pa_b.

data: lv_result TYPE i. " 지역변수 선언
lv_result = pa_a * pa_b.
pv_result = lv_result.
*  pv_a = 10.
*  pv_b = 20.
*  pv_result = 100.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form abc
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM abc .
*  WRITE:/ lv_restlt." 지역 변수이기에 사용 불가
  WRITE:/ gv_result." 전역 변수이기에 사용 가능
ENDFORM.