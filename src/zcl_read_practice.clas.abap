CLASS zcl_read_practice DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_read_practice IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*    READ ENTITY ZI_BD_Travel_M
*    FROM VALUE #( ( %key-TravelId = '00004138' %control = VALUE #( AgencyId   = if_abap_behv=>mk-on
*                                                                   CustomerId = if_abap_behv=>mk-on
*                                                                   BeginDate  = if_abap_behv=>mk-on ) ) )
*    RESULT DATA(lt_res)
*    FAILED DATA(lt_res_fail_short).
*
*    IF lt_res_fail_short IS NOT INITIAL.
*      out->write( lt_res_fail_short ).
*    ELSE.
*      out->write( lt_res ).
*    ENDIF.

*    READ ENTITY ZI_BD_Travel_M
*    FIELDS ( AgencyId BeginDate CustomerId )
*    WITH VALUE #( ( %key-TravelId = '00004138' ) )
*    RESULT DATA(lt_res)
*    FAILED DATA(lt_res_fail_short).
*
*    IF lt_res_fail_short IS NOT INITIAL.
*      out->write( lt_res_fail_short ).
*    ELSE.
*      out->write( lt_res ).
*    ENDIF.

*    READ ENTITY ZI_BD_Travel_M
*    ALL FIELDS
*    WITH VALUE #( ( %key-TravelId = '00004138' )
*                  ( %key-TravelId = '00220102' )  )
*    RESULT DATA(lt_res)
*    FAILED DATA(lt_res_fail_short).
*
*    IF lt_res_fail_short IS NOT INITIAL.
*      out->write( lt_res_fail_short ).
*    ELSE.
*      out->write( lt_res ).
*    ENDIF.

*    READ ENTITY ZI_BD_Travel_M
*    BY \_Booking
*    ALL FIELDS
*    WITH VALUE #( ( %key-TravelId = '00004138' )
*                  ( %key-TravelId = '00220102' )
*                  ( %key-TravelId = '00000001' ) )
*    RESULT DATA(lt_res)
*    FAILED DATA(lt_res_fail_short).
*
*    IF lt_res_fail_short IS NOT INITIAL.
*      out->write( lt_res_fail_short ).
*    ELSE.
*      out->write( lt_res ).
*    ENDIF.

*    READ ENTITIES OF ZI_BD_Travel_M
*    ENTITY ZI_BD_Travel_M
*    ALL FIELDS
*    WITH VALUE #( ( %key-TravelId = '00004138' )
*                  ( %key-TravelId = '00220102' )
*                  ( %key-TravelId = '00000001' ) )
*                   RESULT DATA(lt_res)
*    ENTITY ZI_BD_Booking_M
*    ALL FIELDS
*    WITH VALUE #( ( %key-TravelId = '00000001' %key-BookingId = '0003' ) )
*                   RESULT DATA(lt_res_book)
*                   FAILED DATA(lt_res_fail_short).
*
*
*    IF lt_res_fail_short IS NOT INITIAL.
*      out->write(  'Read Failed'  )->write( lt_res_fail_short ).
*    ELSE.
*      out->write( lt_res ).
*      out->write( lt_res_book ).
*    ENDIF.


    DATA: it_optab       TYPE abp_behv_retrievals_tab,
          it_travel      TYPE TABLE FOR READ IMPORT ZI_BD_Travel_M,
          it_travel_res  TYPE TABLE FOR READ RESULT ZI_BD_Travel_M,
          it_booking     TYPE TABLE FOR READ IMPORT ZI_BD_Travel_M\_Booking,
          it_booking_res TYPE TABLE FOR READ RESULT ZI_BD_Travel_M\_Booking.

    it_travel = VALUE #( ( %key-TravelId = '00004138'
                           %control = VALUE #( AgencyId   = if_abap_behv=>mk-on
                                               CustomerId = if_abap_behv=>mk-on
                                               BeginDate  = if_abap_behv=>mk-on ) ) ).


    it_booking = VALUE #( ( %key-TravelId = '00000001'
                            %control = VALUE #( BookingDate   = if_abap_behv=>mk-on
                                                BookingStatus = if_abap_behv=>mk-on
                                                BookingId     = if_abap_behv=>mk-on ) ) ).


    it_optab = VALUE #( (  op          = if_abap_behv=>op-r-read
                           entity_name = 'ZI_BD_TRAVEL_M'
                           instances   = REF #( it_travel )
                           results     = REF #( it_travel_res ) )

                          ( op         = if_abap_behv=>op-r-read_ba
                           entity_name = 'ZI_BD_TRAVEL_M'
                           sub_name    = '_BOOKING'
                           instances   = REF #( it_booking )
                           results     = REF #( it_booking_res ) ) ).

    READ ENTITIES
    OPERATIONS it_optab
    FAILED DATA(lt_failed_dyn).
    IF lt_failed_dyn IS NOT INITIAL.
      out->write(  'Read Failed'  )->write( lt_failed_dyn ).
    ELSE.
      out->write( it_travel_res ).
      out->write( it_booking_res ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
