@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Details'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@Search.searchable: true
define view entity ZC_BD_BOOKING_M
  as projection on ZI_BD_Booking_M
{
  key TravelId,
  key BookingId,
      BookingDate,
      @ObjectModel.text.element: [ 'CustomerName' ]
      CustomerId,
      _Customer.LastName        as CustomerName,
      @ObjectModel.text.element: [ 'CarrierName' ]
      CarrierId,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      _Connection._Airline.Name as CarrierName,
      ConnectionId,
      FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      FlightPrice,
      CurrencyCode,
      @ObjectModel.text.element: [ 'BookingStatusText' ]
      BookingStatus,
      _BookingStatus._Text.Text as BookingStatusText : localized,
      LastChangedAt,
      /* Associations */
      _BookingStatus,
      _BookingStatusText,
      _BookingSuppliment : redirected to composition child ZC_BD_BOOKING_SUPPL_M,
      _Currency,
      _Connection,
      _Customer,
      _Travel            : redirected to parent ZC_BD_TRAVEL_M
}
