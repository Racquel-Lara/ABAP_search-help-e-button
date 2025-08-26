CLASS LHC_TRAVEL DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR Travel
        RESULT result,
      CALCULATETRAVELID FOR DETERMINE ON SAVE
        IMPORTING
          KEYS FOR  Travel~CalculateTravelID ,
      acceptTravel FOR MODIFY
            IMPORTING keys FOR ACTION Travel~acceptTravel RESULT result.
ENDCLASS.

CLASS LHC_TRAVEL IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD CALCULATETRAVELID.
  READ ENTITIES OF ZI_FE_TRAVEL_2174 IN LOCAL MODE
    ENTITY Travel
      ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(entities).
  DELETE entities WHERE TravelID IS NOT INITIAL.
  Check entities is not initial.
  "Dummy logic to determine object_id
  SELECT MAX( TRAVEL_ID ) FROM ZFE_ATRAV_2174 INTO @DATA(max_object_id).
  "Add support for draft if used in modify
  "SELECT SINGLE FROM FROM ZFE_DTRAV_001173 FIELDS MAX( TravelID ) INTO @DATA(max_orderid_draft). "draft table
  "if max_orderid_draft > max_object_id
  " max_object_id = max_orderid_draft.
  "ENDIF.
  MODIFY ENTITIES OF ZI_FE_TRAVEL_2174 IN LOCAL MODE
    ENTITY Travel
      UPDATE FIELDS ( TravelID )
        WITH VALUE #( FOR entity IN entities INDEX INTO i (
        %tky          = entity-%tky
        TravelID     = max_object_id + i
  ) ).
  ENDMETHOD.
  METHOD acceptTravel.

   READ ENTITIES OF ZI_FE_TRAVEL_2174 IN LOCAL MODE
    ENTITY Travel
      FIELDS ( OverallStatus TravelID )
      WITH CORRESPONDING #( keys )
    RESULT DATA(lt_travels_read).

  DATA lt_travels_for_update TYPE TABLE FOR UPDATE ZI_FE_TRAVEL_2174.

  LOOP AT lt_travels_read INTO DATA(ls_travel).
    IF ls_travel-OverallStatus = 'O'.
      APPEND VALUE #(
          %tky                    = ls_travel-%tky
          OverallStatus           = 'A'
          %control-OverallStatus  = if_abap_behv=>mk-on
      ) TO lt_travels_for_update.
    ELSE.
      APPEND VALUE #(
         %tky = ls_travel-%tky
         %msg = new_message(
             id       = 'ZCM_TUTORIAL_MSG'
             number   = '002'
             v1       = ls_travel-TravelID
             severity = if_abap_behv_message=>severity-information
         )
      ) TO reported-travel.
    ENDIF.
  ENDLOOP.

  IF lt_travels_for_update IS NOT INITIAL.
    MODIFY ENTITIES OF ZI_FE_TRAVEL_2174 IN LOCAL MODE
      ENTITY Travel
        UPDATE FIELDS ( OverallStatus )
        WITH lt_travels_for_update.

    LOOP AT lt_travels_for_update INTO DATA(ls_updated_key).
      DATA(ls_updated_data) = lt_travels_read[ KEY entity %tky = ls_updated_key-%tky ].

      APPEND VALUE #(
          %tky = ls_updated_data-%tky
          %msg = new_message(
              id       = 'ZCM_TUTORIAL_MSG'
              number   = '001'
              v1       = ls_updated_data-TravelID
              severity = if_abap_behv_message=>severity-success
          )
      ) TO reported-travel.

      " 🔹 Preencher o RESULT
      APPEND VALUE #(
          %tky   = ls_updated_data-%tky
          TravelUUID = ls_updated_data-TravelUUID
      ) TO result.
    ENDLOOP.
  ENDIF.

  ENDMETHOD.

ENDCLASS.
