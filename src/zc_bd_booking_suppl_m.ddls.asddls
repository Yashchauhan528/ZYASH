@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement Details'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_BD_BOOKING_SUPPL_M
  as projection on ZI_BD_Booking_Suppl_M
{
  key TravelId,
  key BookingId,
  key BookingSupplementId,
      @ObjectModel.text.element: [ 'SupplementText' ]
      SupplementId,
      _SupplementText.Description                       as SupplementText         : localized,
      @ObjectModel.text.element: [ 'SupplementCategoryText' ]
      _Supplement.SupplementCategory                    as SupplementCategory,
      _Supplement._SupplementCategory._Text.Description as SupplementCategoryText : localized,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      CurrencyCode,
      LastChangedAt,
      /* Associations */
      _Booking : redirected to parent ZC_BD_BOOKING_M,
      _Currency,
      _Travel  : redirected to ZC_BD_TRAVEL_M,
      _Supplement,
      _SupplementText
}
