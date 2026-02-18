CLASS zcl_datagen DEFINITION

  PUBLIC

  FINAL

  CREATE PUBLIC .



  PUBLIC SECTION.

    INTERFACES:

      if_oo_adt_classrun.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.







CLASS zcl_datagen IMPLEMENTATION.





  METHOD if_oo_adt_classrun~main.



    " delete existing entries in the database table

    DELETE FROM ztravel_YASH_m.

    DELETE FROM zYASH_BOOKING_m.

    DELETE FROM zbooksupL_YASH_m.

    COMMIT WORK.

    " insert travel demo data

    INSERT ztravel_YASH_m FROM (

        SELECT *

          FROM /dmo/travel_m

      ).

    COMMIT WORK.



    " insert booking demo data

    INSERT zYASH_BOOKING_m FROM (

        SELECT *

          FROM   /dmo/booking_m

*            JOIN ztravel_tech_m AS z

*            ON   booking~travel_id = z~travel_id



      ).

    COMMIT WORK.

    INSERT zbooksupL_YASH_m FROM (

        SELECT *

          FROM   /dmo/booksuppl_m

*            JOIN ztravel_tech_m AS z

*            ON   booking~travel_id = z~travel_id



      ).

    COMMIT WORK.



    out->write( 'Travel and booking demo data inserted.').





  ENDMETHOD.

ENDCLASS.
