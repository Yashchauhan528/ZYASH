CLASS lhc_ZI_BD_Travel_M DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR ZI_BD_Travel_M RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR ZI_BD_Travel_M RESULT result.
    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE ZI_BD_Travel_M.

ENDCLASS.

CLASS lhc_ZI_BD_Travel_M IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.

    DATA(lt_entities) = entities.

    DELETE lt_entities WHERE TravelId IS NOT INITIAL.
    TRY.
        cl_numberrange_runtime=>number_get(
          EXPORTING
            nr_range_nr       = '01'
            object            = '/dmo/trv_m'
            quantity          = CONV #( lines( lt_entities ) )
          IMPORTING
            number            = DATA(lv_num)
            returncode        = DATA(lv_code)
            returned_quantity = DATA(lv_qty)
        ).
      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges INTO DATA(lo_error).

        LOOP AT lt_entities INTO DATA(ls_entities) .

          APPEND VALUE #(  %cid = ls_entities-%cid
                           %key = ls_entities-%key ) TO failed-zi_bd_travel_m .


          APPEND VALUE #(  %cid = ls_entities-%cid
                           %key = ls_entities-%key
                           %msg = lo_error ) TO reported-zi_bd_travel_m .

        ENDLOOP.

        EXIT.

    ENDTRY.

    ASSERT lv_qty = lines( lt_entities ).

*    DATA: lt_bd_travel_m TYPE TABLE FOR MAPPED EARLY zi_bd_travel_m,
*          ls_bd_travel_m LIKE LINE OF lt_bd_travel_m.

    DATA(lv_curr_num) = CONV i( lv_num - lv_qty ).

    LOOP AT lt_entities INTO DATA(ls_item).

      lv_curr_num += 1.

*      ls_bd_travel_m = VALUE #( %cid = ls_item-%cid
*                                TravelId = lv_curr_num ).
*
*      APPEND ls_bd_travel_m TO mapped-zi_bd_travel_m.

      APPEND VALUE #(  %cid = ls_item-%cid
                               TravelId = lv_curr_num ) TO mapped-zi_bd_travel_m .

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
