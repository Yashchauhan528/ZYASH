@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Details'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_BD_Booking_M
  as select from /dmo/booking_m
  association        to parent ZI_BD_Travel_M         as _Travel            on  $projection.TravelId = _Travel.TravelId
  composition [0..*] of ZI_BD_Booking_Suppl_M         as _BookingSuppliment
  association [0..1] to /DMO/I_Customer               as _Customer          on  $projection.CustomerId = _Customer.CustomerID
  association [0..1] to /DMO/I_Connection             as _Connection        on  $projection.ConnectionId = _Connection.ConnectionID
                                                                            and $projection.CarrierId    = _Connection.AirlineID
  association [0..1] to I_Currency                    as _Currency          on  $projection.CurrencyCode = _Currency.Currency
  association [0..1] to /DMO/I_Booking_Status_VH      as _BookingStatus     on  $projection.BookingStatus = _BookingStatus.BookingStatus
  association [0..*] to /DMO/I_Booking_Status_VH_Text as _BookingStatusText on  $projection.BookingStatus = _BookingStatusText.BookingStatus
{
  key travel_id       as TravelId,
  key booking_id      as BookingId,
      booking_date    as BookingDate,
      customer_id     as CustomerId,
      carrier_id      as CarrierId,
      connection_id   as ConnectionId,
      flight_date     as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price    as FlightPrice,
      currency_code   as CurrencyCode,
      booking_status  as BookingStatus,
      last_changed_at as LastChangedAt,
      _BookingSuppliment,
      _Travel,
      _Customer,
      _Connection,
      _Currency,
      _BookingStatus,
      _BookingStatusText
}
