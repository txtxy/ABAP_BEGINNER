 

DATA : lv_line TYPE int4,
       l_generic_struc TYPE REF TO data,
       l_generic_table TYPE REF TO data,
       lv_index TYPE sy-tabix.

DATA : d_tab   TYPE REF   TO data,
       d_line  TYPE REF   TO data,
       lt_fcat TYPE TABLE OF lvc_s_fcat,
       ls_fcat LIKE LINE  OF lt_fcat,
       nametab LIKE dntab OCCURS 0 WITH HEADER LINE.


 

  DATA : tdd02l LIKE dd02l.


FIELD-SYMBOLS :  <table> TYPE ANY,  "안씀...
                 <struc> TYPE ANY,
                <field> TYPE ANY.

FIELD-SYMBOLS : <new_tab>  TYPE table,
                <new_line> TYPE ANY.

PARAMETERS : p_tname LIKE dd03l-tabname  OBLIGATORY.
 
AT SELECTION-SCREEN.

  SELECT * FROM  dd02l    "db가 존재하는지 체크한다.
         INTO tdd02l
         WHERE  tabname  = p_tname
         AND    as4local = 'A'
         AND   ( tabclass      <> 'INTTAB'
                 AND tabname   <> 'APPEND'
                 AND tabclass  <> 'VIEW' ).
    EXIT.
  ENDSELECT.
  IF sy-subrc <> 0.  MESSAGE e402(mo) WITH p_tname.  ENDIF.


START-OF-SELECTION.

*  CREATE DATA l_generic_table TYPE TABLE OF (p_tname).
*  ASSIGN l_generic_table->* TO <table>.
*
*  CREATE DATA l_generic_struc TYPE (p_tname).
*  ASSIGN l_generic_struc->* TO <struc>.

* Field catalog get
  CALL FUNCTION 'NAMETAB_GET'
    EXPORTING
      langu          = sy-langu
      tabname        = p_tname
    TABLES
      nametab        = nametab
    EXCEPTIONS
      no_texts_found = 1.

  SORT nametab BY position.

  CLEAR : lt_fcat[].

  LOOP AT nametab.
* Internal table
    IF sy-subrc = 0.
      ls_fcat-fieldname =  nametab-fieldname.
      ls_fcat-ref_table =  p_tname.
      ls_fcat-ref_field =  nametab-fieldname.
      APPEND  ls_fcat  TO lt_fcat.
    ENDIF.
  ENDLOOP.

  IF  lt_fcat[]  IS  INITIAL.
    STOP.
  ENDIF.

* Internal table create   "dynamic Internal table
  CALL METHOD cl_alv_table_create=>create_dynamic_table
    EXPORTING
      it_fieldcatalog = lt_fcat
    IMPORTING
      ep_table        = d_tab.

  ASSIGN d_tab->*  TO  <new_tab>. "fs에 동적 테이블 선언
  CREATE DATA d_line LIKE LINE OF <new_tab>.
  ASSIGN d_line->* TO <new_line>. "fs에 동적 스트럭쳐 선언

  SELECT * FROM (p_tname) INTO TABLE <new_tab>.  "데이터 가져와서 동적 테이블에 담기.

  IF sy-subrc = 0.
    LOOP AT <new_tab> ASSIGNING <new_line>.
      READ TABLE nametab WITH KEY fieldname = 'BUKRS'.
      lv_index = nametab-position.  "필드 포지션을 읽음...
      ASSIGN COMPONENT lv_index OF STRUCTURE <new_line> TO <field>.  "필드 내용을 동적으로 담기.
      IF <field> = '2000'.
        <field> = '1000'.
      ELSE.
        WRITE : '예외 회사코드가 있습니다'.
        STOP.
      ENDIF.
    ENDLOOP.
    INSERT (p_tname) FROM TABLE <new_tab>.
    IF sy-subrc = 0.
      DESCRIBE TABLE <new_tab> LINES lv_line.
      COMMIT WORK.
      WRITE :lv_line , '건이 들어갔습니다'.

    ELSE.
      ROLLBACK WORK.
      WRITE : '데이터 저장 실패!!!!!'.
    ENDIF.
  ENDIF.


END-OF-SELECTION.