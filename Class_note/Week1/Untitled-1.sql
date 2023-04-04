
SELECT  PP_DOC_NUM WH_ID ERNAM ERDAT ERZET AENAM AEDAT AEZET
   INTO CORRESPONDING FIELDS OF GS_PPH
   FROM ztc_pp_end_list
   WHERE PP_DOC_NUM IN SO_ID
   ORDER BY PP_DOC_NUM.

  SELECT SINGLE COUNT( * ) AS SKU_CNT
    FROM ztc_pp_end_list
    INTO gs_pph-sku_cnt
    WHERE pp_doc_num = gs_pph-pp_doc_num
    GROUP BY PP_DOC_NUM.


*MOVE-CORRESPONDING gs_PPH TO ls_PPH.

APPEND GS_PPH TO GT_PPH.


CLEAR : Gs_PPH.





data : lv_cnt type i,
       lv_doc_num type ztc_pp_end_list-pp_doc_num.
DATA : lv_index TYPE sy-index.

SELECT  *
   INTO CORRESPONDING FIELDS OF table lt_PPH
   FROM ztc_pp_end_list
   WHERE PP_DOC_NUM IN SO_ID
   ORDER BY PP_DOC_NUM.

loop at lt_PPH INTO ls_PPH.
    if ls_PPH-PP_DOC_NUM <> lv_doc_num and lv_doc_num is not initial.

     ls_pph-sku_cnt = lv_cnt.

      lv_index = sy-index - 1.
    APPEND ls_PPH to lt_PPH .
    
    clear: lv_cnt, lv_doc_num.
    lv_doc_num = gs_pph-pp_doc_num .
    
    else. 

    endif.
    add 1 to lv_cnt.

endloop.



