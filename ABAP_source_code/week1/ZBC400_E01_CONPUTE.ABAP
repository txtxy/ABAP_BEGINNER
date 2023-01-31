*&---------------------------------------------------------------------*
*& Report ZBC400_E01_COMPUTE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC400_E01_COMPUTE.

PARAMETERS: pa_in1 TYPE i,
            pa_op  TYPE c LENGTH 1, " TYPE char1도 같은 기능
            pa_in2 TYPE i.


DATA gv_result  TYPE p  LENGTH 16 DECIMALS 2.


CASE pa_op.
  WHEN '+'.
    gv_result = pa_in1 + pa_in2.
    WRITE:'it is the Addition '(001),gv_result LEFT-JUSTIFIED.

  WHEN '-'.
    gv_result = pa_in1 - pa_in2.
    WRITE:'it is the Subtraction '(002),gv_result LEFT-JUSTIFIED.

  WHEN '*'.
    gv_result = pa_in1 * pa_in2.
    WRITE:'it is the Multipilcation '(003),gv_result LEFT-JUSTIFIED.

  WHEN '/'.
    IF pa_in2 < 1.
      WRITE: 'Can`t Divide zero.'(100).
    else.
      gv_result = pa_in1 / pa_in2.
      WRITE:'No Division by Zero '(004),gv_result LEFT-JUSTIFIED.
    ENDIF.

*  WHEN '**'.
*    gv_result = pa_in1 ** pa_in2.
*    WRITE:'it is the Exponentiation : '(005),gv_result LEFT-JUSTIFIED.
*
*  WHEN 'DIV'.
*    IF  pa_in1 < 1 or pa_in2 < 1.
*      WRITE: 'Can`t Divde zero.'(100).
*    else.
*      gv_result = pa_in1 DIV pa_in2.
*      WRITE:'it is the DIV '(006),gv_result LEFT-JUSTIFIED.
*    ENDIF.
*
*  WHEN 'MOD'.
*    IF  pa_in1 < 1 or pa_in2 < 1.
*      WRITE: 'Can`t calculate zero.'(100).
*    else.
*      gv_result = pa_in1 MOD pa_in2.
*      WRITE:'it is the MOD '(007),gv_result LEFT-JUSTIFIED.
*    endif.

  WHEN OTHERS.
    WRITE:'Invalid Operator!'(200).

ENDCASE.