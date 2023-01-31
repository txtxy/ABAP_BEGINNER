*&---------------------------------------------------------------------*
*& Report ZABAP_E01_029
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_e01_029.
* Character like Structure variable 선언
data : BEGIN OF ls_char,
          col1 TYPE char10,
          col2 TYPE char15,
          col3 TYPE dats,
          col4 TYPE tims,
          col5 TYPE num10,
        END OF ls_char.

ls_char-col1 ='가나다라'.
ls_char-col2 = 'abcdef'.
ls_char-col3 = sy-datum.
ls_char-col4 = sy-uzeit.
ls_char-col5 = '87380'.

WRITE:at /20 ls_char.