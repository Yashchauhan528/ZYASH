CLASS ycl_read_practise DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_read_practise IMPLEMENTATION.

METHOD if_oo_adt_classrun~main.


"Operations & Dynamic Form

data: it_optab type abp_behv_retrievals_tab.
data: it_travel type table for read import ZI_BD_Travel_M.
data: it_travel_result type table for read result ZI_BD_Travel_M.

data: it_booking type table for read import ZI_BD_Travel_M\_Booking.
data: it_booking_result type table for read result ZI_BD_Travel_M\_Booking.


it_travel =  VALUE #( ( %key-TravelId = '0000000097'
                 %control = VALUE #(  AgencyId = if_abap_behv=>mk-on
                                      CustomerId = if_abap_behv=>mk-on
                                      BeginDate = if_abap_behv=>mk-on )
                                      ) ).


it_booking =  VALUE #( ( %key-TravelId = '0000000097'
                 %control = VALUE #(  BookingDate = if_abap_behv=>mk-on
                                      BookingStatus = if_abap_behv=>mk-on
                                      BookingId = if_abap_behv=>mk-on )
                                      ) ).





it_optab = value #( ( op = if_abap_behv=>op-r-read
                      entity_name = 'ZI_BD_Travel_M'
                      instances = REF #( it_travel )
                      results = REF #( it_travel_result ) )
                      ( op = if_abap_behv=>op-r-read_ba
                      entity_name = 'ZI_BD_Travel_M'
                      sub_name = '_booking'
                      instances = REF #( it_booking )
                      results = REF #( it_booking_result )

) ).



READ ENTITIES operations IT_OPTAB failed DATA(LT_FAILED_DY).

IF LT_FAILED_DY IS NOT INITIAL.
 OUT->WRITE( 'READ FAILED' ).
 ELSE.
 OUT->WRITE( it_travel_result ).
 OUT->WRITE( it_booking_result ).
 ENDIF.

  ENDMETHOD.




ENDCLASS.
