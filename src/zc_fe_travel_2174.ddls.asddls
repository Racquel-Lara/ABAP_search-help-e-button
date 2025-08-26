@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forTravel'
@ObjectModel.semanticKey: [ 'TravelID' ]
@Search.searchable: true
define root view entity ZC_FE_TRAVEL_2174
  provider contract transactional_query
  as projection on ZI_FE_TRAVEL_2174 as Travel
{
  key TravelUUID,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
    @Consumption.valueHelpDefinition: [ {
  entity: {
    name: 'ZC_FE_TRAVEL_001174_VH',
    element: 'TravelID'
  }
} ]
  
  TravelID,
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: '/DMO/I_Agency', 
      element: 'AgencyID'
    }
  } ]
  AgencyID,
  CustomerID,
  BeginDate,
  EndDate,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  BookingFee,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  TotalPrice,
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: 'I_Currency', 
      element: 'Currency'
    }
  } ]
  CurrencyCode,
  Description,
  @ObjectModel.text.element: [ 'TravelStatusText' ]
  OverallStatus,
  OverallStatusCriticality,
  _TravelStatus.TravelStatusText as TravelStatusText,
  CreatedBy,
  CreatedAt,
  LastChangedBy,
  LastChangedAt,
  LocalLastChangedAt,
  _Booking : redirected to composition child ZC_FE_BOOKING_2174,
  _Agency,
  _Currency,
  _Customer,
  _TravelStatus
  
}
