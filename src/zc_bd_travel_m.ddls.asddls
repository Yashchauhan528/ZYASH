@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel Details'
@Metadata: { ignorePropagatedAnnotations: true,
allowExtensions: true }
@Search.searchable: true
define root view entity ZC_BD_TRAVEL_M
  provider contract transactional_query
  as projection on ZI_BD_Travel_M
{
  key TravelId,
      @ObjectModel.text.element: [ 'AgencyName' ]
      @Consumption.valueHelpDefinition: [{
          entity: {
              name: '/DMO/I_Agency',
              element: 'AgencyID'
          }}]
      AgencyId,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      _Agency.Name              as AgencyName,
      @ObjectModel.text.element: [ 'CustomerName' ]
      @Consumption.valueHelpDefinition: [{
        entity: {
            name: '/DMO/I_Customer',
            element: 'CustomerID'
        }}]
      CustomerId,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      _Customer.LastName        as CustomerName,
      BeginDate,
      EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,
      @Consumption.valueHelpDefinition: [{
        entity: {
            name: 'I_Currency',
            element: 'Currency'
        }}]
      CurrencyCode,
      Description,
      @ObjectModel.text.element: [ 'OverallStatusText' ]
      @Consumption.valueHelpDefinition: [{
        entity: {
            name: '/DMO/I_Overall_Status_VH',
            element: 'OverallStatus'
        }}]
      OverallStatus,
      _OverallStatus._Text.Text as OverallStatusText : localized,
      //      CreatedBy,
      //      CreatedAt,
      //      LastChangedBy,
      LastChangedAt,
      /* Associations */
      _Agency,
      _Booking : redirected to composition child ZC_BD_BOOKING_M,
      _Currency,
      _Customer,
      _OverallStatus
}
