@EndUserText.label: 'Value Help for Travel ID'
@Search.searchable: true
define view entity ZC_FE_TRAVEL_2174_VH
  as select from ZI_FE_TRAVEL_2174
{
  key TravelID,
      Description
}
