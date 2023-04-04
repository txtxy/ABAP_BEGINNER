
DATA: ls_data LIKE gs_data.

DATA: ls_ord TYPE ztc_sd_ord_i,
      lt_ord LIKE TABLE OF ls_ord.

SORT gt_data BY del_bp_id del_type del_req_date.


LOOP AT gt_data INTO gs_data.

  IF gs_data-out_qty <> 0.
    IF sy-tabix <> 1.
      IF gs_data-del_bp_id <> ls_data-del_bp_id OR 
         gs_data-del_type <> ls_data-del_type OR 
         gs_data-del_req_date <> ls_data-del_req_date.
        PERFORM get_num.
      ENDIF.

    ELSEIF sy-tabix = 1.
      PERFORM get_num.
    ENDIF.
  ENDIF.

  gs_data-out_doc_num = gv_num.
  gs_data-out_flag = 'X'.
  gs_data-status = icon_led_green.

  MOVE-CORRESPONDING gs_data TO ls_data.
  MODIFY gt_data FROM gs_data.

  UPDATE ztc_sd_ord_i SET out_qty = gs_data-out_qty
                          out_unit = 'EA'
      WHERE ord_doc_num = gs_data-ord_doc_num
        AND itm_num = gs_data-itm_num
        AND sku_id = gs_data-sku_id
        AND batch = gs_data-batch.


  UPDATE ztc_sd_ord_i SET out_doc_num = gs_data-out_doc_num
    WHERE ord_doc_num = gs_data-ord_doc_num
    AND out_qty <> '0'.



ENDLOOP.



LOOP AT gt_out INTO gs_out.
  MOVE-CORRESPONDING gs_data TO gs_out.
  MODIFY gt_out FROM gs_out.
  CLEAR: gs_out.
ENDLOOP.
